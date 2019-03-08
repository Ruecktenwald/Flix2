class MoviesController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_movie, only: [:show,:edit,:update,:destroy]



  def index
    case params[:scope]
    when 'hits'
      @movies = Movie.hits
    when 'flops'
      @movies = Movie.flops
    when 'upcoming'
      @movies = Movie.upcoming
    when 'recent'
      @movies = Movie.recent
    else
    @movies = Movie.released
  end
  end

  def show
    
    @fans = @movie.fans
      if current_user
      @current_favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
    @genres = @movie.genres
  end

  def edit
 
  end

  def update
   
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie successfully updated!"
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created!"
    else
      render :new
    end
  end

  def destroy
    
    @movie.destroy
    redirect_to movies_url, alert: "Movie successfully deleted!"
  end

private

  def movie_params
    params.require(:movie).
      permit(:title, :description, :rating, :released_on, :total_gross, :cast, :director, :duration, :image_file_name, genre_ids: [])
  end
  def set_movie
    @movie = Movie.find_by!(slug: params[:id])
  end
  
end
