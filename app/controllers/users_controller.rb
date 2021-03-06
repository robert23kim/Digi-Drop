class UsersController < ApplicationController

  @@added_asset = nil

  def show
    id = params[:id] # retrieve movie ID from URI route
    @user = User.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default

    #Adds balance value to nav bar if logged in
    #byebug
    @userBal = "$0"
    if !session[:user_id].nil? #and !session[:user_id].empty?
      id = session[:user_id]
      @userBal = User.balanceToString(User.find(id))
    end
    @collectibles = Collectible.usersCollection(@user)
  end

  def index
    #byebug
    @users = User.all
    @cases = Case.select('*')

    @countItemsHash = Hash.new
    @sumValueHash = Hash.new
    @users.each do |user|
      @countItemsHash[user.id] = Collectible.joins('INNER JOIN "assets" ON "assets"."collectible_id" = "collectibles"."id" INNER JOIN "users" ON "users"."id" = "assets"."user_id"').where("users.username = ?", user.username).count
      @sumValueHash[user.id] = Collectible.joins('INNER JOIN "assets" ON "assets"."collectible_id" = "collectibles"."id" INNER JOIN "users" ON "users"."id" = "assets"."user_id"').where("users.username = ?", user.username).sum(:value)
    end

    #Adds balance value to nav bar if logged in
    @userBal = "$0"
    if !session[:user_id].nil? #and !session[:user_id].empty?
      id = session[:user_id]
      @user = User.find(id) # look up movie by unique ID
      @userBal = User.balanceToString(User.find(id))
    end

    #@users = @users.sort_by { |u| @sumValueHash[u.id] }.reverse
    @users = @users.sort_by {|u| @countItemsHash[u.id]}.reverse
  end

  def market
    @user = User.find params[:id]

    @products = Product.products()
    @userBal = "$0"
    if !session[:user_id].nil? #and !session[:user_id].empty?
      id = session[:user_id]
      @userBal = User.balanceToString(User.find(id))
    end
    @collectibles = Collectible.usersCollection(@user)
  end

  def new
    @user = User.new
  end

  def create
    #byebug
    @user = User.new(user_params)

    if !!User.find_by(username: user_params[:username])
      redirect_to '/users/new', notice: "Username already exists"
    elsif @user.save
      session[:user_id] = @user.id
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
  end

  def open
    @user = User.find params[:user_id]

    @cases = Case.select('*')
    @active_case = if params[:case_name].nil?
                     Case.find_by name: "Featured"
                   else
                     Case.find_by name: params[:case_name]
                   end
    @price = @active_case.value
    if not @active_case.value.nil?
      @price = '%.2f' % @active_case.value
    end

    @case_contents = Collectible.select('"collectibles"."id" as id, "collectibles"."url" as url, "collectibles"."name" as name, rarity')
                         .joins('INNER JOIN "contents" ON "collectibles"."id" = "contents"."collectible_id"')
                         .joins('INNER JOIN "cases" ON "cases"."id" = "contents"."case_id"')
                         .where("cases.name = ?", @active_case.name)

    # map the asset to the corresponding collectible for display
    if !@@added_asset.nil?
      @added_collectible = Collectible.select('*')
                               .joins('INNER JOIN "assets" ON "assets"."collectible_id" = "collectibles"."id"')
                               .where("assets.collectible_id = ?", @@added_asset.collectible_id)
                               .first
    end

    #Adds balance value to nav bar if logged in
    @userBal = "$0"
    if !session[:user_id].nil? #and !session[:user_id].empty?
      id = session[:user_id]
      @userBal = User.balanceToString(User.find(id))
    end
    # reset back to nil
    @@added_asset = nil
  end

  def add
    @user = User.find params[:user_id]

    @active_case = if params[:case_name].nil?
                     Case.find_by name: "Featured"
                   else
                     Case.find_by name: params[:case_name]
                   end

    new_balance = @user.balance.to_f - @active_case.value.to_f
    if new_balance < 0
      redirect_to :back, notice: "Insufficient Balance"
    else
      # Logic, first pick out rarity based on probability C: 60, N: 25, R: 10, SR: 5
      @rarity = nil
      @random = rand(1..100)

      case @random
      when 1..60
        @rarity = 'C'
      when 61..85
        @rarity = 'N'
      when 86..95
        @rarity = 'R'
      when 96..100
        @rarity = 'SR'
      end

      # Only choose from contents of a specific case, of the selected rarity chosen above
      @case_contents = Content.select('*')
                           .joins('INNER JOIN "collectibles" ON "collectibles"."id" = "contents"."collectible_id"')
                           .joins('INNER JOIN "cases" ON "cases"."id" = "contents"."case_id"')
                           .where("cases.name = ?", params[:case_name])
                           .where("collectibles.rarity = ?", @rarity)

      # Set random blur value, 1.5px max blur
      superRareBlurNum = nil
      if @rarity == 'SR'
        superRareBlurNum = rand(1..100)
        superRareBlurNum = superRareBlurNum * 1.5
      end

      # Then pick out the specific items.
      @@added_asset = Asset.create(:user_id => @user.id, :collectible_id => @case_contents[rand(@case_contents.size)].collectible_id, :blurNum => superRareBlurNum)
      User.where(id: @user.id).update_all(balance: new_balance)
      @userBal = new_balance
      redirect_to open_path(@user, @active_case.name)
    end
  end

  def add_balance
    @user = User.find params[:id]

    @userBal = "$0"
    if !session[:user_id].nil? #and !session[:user_id].empty?
      id = session[:user_id]
      @userBal = User.balanceToString(User.find(id))
    end
    #byebug
    #if params[:amount].nil?
    #  redirect_to add_balance_user_path(@user)
    #else
    #  redirect_to user_path(@user)
    #end
  end

  def update
    #byebug
    @user = User.find params[:id]
    if !User.numeric?(params[:amount]) or Float(params[:amount]) < 0
      flash[:notice] = "Invalid input for Amount"
      redirect_to add_balance_user_path(@user)
    else
      amt = Float(params[:amount])
      #byebug
      #check if amt is numerical
      if @user.balance.nil?
        @user.balance = amt
      else
        @user.balance = @user.balance + amt
      end
      @user.save
      redirect_to user_path(@user)
    end
  end

  def destroy
  end

  def sell
    @user = User.find params[:user_id]
    Product.create(:user_id => params[:user_id], :asset_id => params[:asset_id], :sell_price => params[:price])
    Asset.where(id: params[:asset_id]).update_all(on_the_market: 1)
    redirect_to user_path(@user)
  end

  def unlist
    @user = User.find params[:user_id]
    Product.where(asset_id: params[:asset_id]).destroy_all
    Asset.where(id: params[:asset_id]).update_all(on_the_market: 0)
    #redirect_to user_path(@user)
    redirect_to(:back)
  end

  def buy
    buyer_balance = User.where(id: params[:buyer_id]).first.balance
    seller_balance = User.where(id: params[:seller_id]).first.balance
    price = params[:price].to_f
    if buyer_balance < price
      redirect_to :back, notice: "Insufficient Balance"
    else
      Asset.where(id: params[:asset_id]).update_all(user_id: params[:buyer_id], on_the_market: 0)
      User.where(id: params[:buyer_id]).update_all(balance: (buyer_balance - price))
      User.where(id: params[:seller_id]).update_all(balance: (seller_balance + price))
      Product.where(asset_id: params[:asset_id]).destroy_all
      redirect_to :back, notice: "Your purchase was successful"
    end
  end

  private

  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def user_params
    params.require(:user).permit(:username, :password)
  end
  #def bal_params
  #  params.require(:user).permit(:card_number, :expiration_date, :CVC, :billing_address, :city, :state, :ZIP, :amount)
  #end
end
