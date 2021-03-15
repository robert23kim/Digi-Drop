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
  end

  def new
  end

  def create
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
    @user = User.find params[:id]
      
    # map the asset to the corresponding collectible for display
    if !@@added_asset.nil?
        @added_collectible = Collectible.select('*')
            .joins('INNER JOIN "assets" ON "assets"."collectible_id" = "collectibles"."id"')
            .where("assets.collectible_id = ?", @@added_asset.collectible_id)
    end
    
    # reset back to nil
    @@added_asset = nil  
  end
    
  def add_asset
    @user = User.find params[:id]  
    
    # note: completely random, does not take rarity into account yet
    @collectible_ids = Collectible.select('collectible_id')
    @@added_asset = Asset.create(:user_id => @user.id, :collectible_id => rand(@collectible_ids.size) + 1) 
    redirect_to open_case_user_path(@user)
  end

  def update
  end

  def destroy
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
