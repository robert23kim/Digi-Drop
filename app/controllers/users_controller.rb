class UsersController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @user = User.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  
    assets = Assets.where(user_id:id) # retrieve {:user_id => 1, :collectible_id => 2}
    #collectible_id_from_assets = assets.collectible_id # extracts collectible_id from assets
    #@collectibles = Colletibles.where(id:assets.collectible_id)
    @collectibles = Collectible.all
  end

  def index
    @users = User.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = User.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
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
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end
end
