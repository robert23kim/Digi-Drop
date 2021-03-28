class UsersController < ApplicationController

  @@added_asset = nil
    
  def show
    id = params[:id] # retrieve movie ID from URI route
    @user = User.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    @collectibles = Collectible.usersCollection(@user)
  end

  def index
    @users = User.all
    @countItemsHash = Hash.new
    @sumValueHash = Hash.new
    @users.each do |user|
      @countItemsHash[user.id] = Collectible.joins('INNER JOIN "assets" ON "assets"."collectible_id" = "collectibles"."id" INNER JOIN "users" ON "users"."id" = "assets"."user_id"').where("users.username = ?", user.username).count
      @sumValueHash[user.id] = Collectible.joins('INNER JOIN "assets" ON "assets"."collectible_id" = "collectibles"."id" INNER JOIN "users" ON "users"."id" = "assets"."user_id"').where("users.username = ?", user.username).sum(:value)
    end
    @users = @users.sort_by{|u| @sumValueHash[u.id]}.reverse
  end
  
  def market
    @user = User.find params[:id]
    @products = Product.products()
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

  def update
  end

  def destroy
  end

  def sell
    @user = User.find params[:user_id] 
    Product.create(:user_id => params[:user_id], :asset_id => params[:asset_id], :sell_price => params[:price])
    Asset.where(id: params[:asset_id]).update_all(on_the_market: true)
    redirect_to user_path(@user)
  end

  def unlist
    @user = User.find params[:user_id]
    Product.where(asset_id: params[:asset_id]).destroy_all
    Asset.where(id: params[:asset_id]).update_all(on_the_market: false)
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
      Asset.where(id: params[:asset_id]).update_all(user_id: params[:buyer_id], on_the_market: false)
      User.where(id: params[:buyer_id]).update_all(balance: (buyer_balance-price))
      User.where(id: params[:buyer_id]).update_all(balance: (seller_balance+price))
      Product.where(asset_id: params[:asset_id]).destroy_all
      redirect_to :back, notice: "Your purchase was successful"
    end
    #@user = User.find params[:user_id]
    #Product.where(asset_id: params[:asset_id]).destroy_all
    #Asset.where(id: params[:asset_id]).update_all(on_the_market: false)
    #redirect_to user_path(@user)
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
