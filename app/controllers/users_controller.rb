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
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
    @movie = User.find params[:id]
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
    params.require(:user).permit(:username, :password)
  end
end
