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
      @userBal = User.balanceToString(User.find(id))
    end
    
    @users = @users.sort_by{|u| @sumValueHash[u.id]}.reverse
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
    
  def open_case
    # byebug
    @user = User.find params[:id]
    #byebug
    # map the asset to the corresponding collectible for display
    if !@@added_asset.nil?
        @added_collectible = Collectible.select('*')
            .joins('INNER JOIN "assets" ON "assets"."collectible_id" = "collectibles"."id"')
            .where("assets.collectible_id = ?", @@added_asset.collectible_id)
      #byebug
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
    
  def add_asset
    @user = User.find params[:id]  
    #byebug
    # note: completely random, does not take rarity into account yet
    @collectible_ids = Collectible.select('id')
    @@added_asset = Asset.create(:user_id => @user.id, :collectible_id => rand(@collectible_ids.size) + 1)
    #byebug
    redirect_to open_case_user_path(@user)
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
    redirect_to user_path(@user)
  end

  def destroy
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
