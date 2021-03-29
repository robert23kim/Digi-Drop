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
    
  def add_asset()
    @user = User.find params[:id]
      
    @collectible_ids = Collectible.select('id')
      
#     # Logic, first pick out rarity based on probability C: 60, N: 25, R: 10, SR: 5 
#     @rarity = nil
#     @random = rand(1..100)
 
#     case @random
#     when 1..60
#         @rarity = 'C'
#     when 61..85
#         @rarity = 'N'
#     when 86..95
#         @rarity = 'R'
#     when 96..100
#         @rarity = 'SR'
#     end
      
#     # Only choose from contents of a specific case
#     @collectible_ids = Content.select('collectible_id')
#         .joins('INNER JOIN "collectibles" ON "collectibles"."_id" = "contents"."collectible_id"')
#         .where("contents.case_id = ?", case_id)
#         .where("collectibles.rarity = ?", @rarity)

    # Then pick out the specific items.  
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
