class UsersController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @user = User.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    @collectibles = Collectible.select('*').joins('INNER JOIN "assets" ON "assets"."collectible_id" = "collectibles"."id" INNER JOIN "users" ON "users"."id" = "assets"."user_id"').where("users.username = ?", @user.username)
  end

  def index
    @users = User.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @user = User.create!(movie_params)
    flash[:notice] = "#{@user.title} was successfully created."
    redirect_to users_path
  end

  def edit
    @user = User.find params[:id]
  end
    
  def open_case
    @user = User.find params[:id]
  end
    
  def add_collectible
    @user = User.find params[:id]
    Asset.create(:user_id=>'1', :collectible_id=>'4') 
    redirect_to user_path(@user)
  end

  def update
    @movie = User.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = User.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def others_by_same_director
    id = params[:id] # retrieve movie ID from URI route
    movie = User.find(id)
    director_selected = movie.director
#     if director_selected == nil
    if  director_selected.blank? or director_selected.nil?
      flash[:notice] = "'#{movie.title}' has no director info"
      redirect_to root_path
    else
      @movies = User.with_director(director_selected)
    end
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def user_params
    params.require(:user).permit(:username)
  end
end
