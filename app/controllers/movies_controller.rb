class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
        @movies = Movie.all
        #@all_ratings = Movie.all_ratings
        @all_ratings = ['G', 'PG', 'PG-13', 'R']
        
        @@cache_ratings = @cache_ratings
        
        if params[:sort]
          @sort = params[:sort]
        else
          @sort = session[:sort]
        end
        
        if @sort
          @movies = @movies.order(@sort)
        end
        
        if params[:ratings]
          @ratings_selected = params[:ratings].keys
        elsif @@cache_ratings
          @ratings_selected = @cache_ratings
        else
          @ratings_selected = @all_ratings
        end
        
        if @sort!=session[:sort]
          session[:sort] = @sort
        end
        
        if @ratings_selected!=@cache_ratings
          @cache_ratings = @ratings_selected
        end
        
        @movies = @movies.where('rating in (?)', @ratings_selected)
        
      end
  
    def new
      # default: render 'new' template
    end
  
    def create
      @movie = Movie.create!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    end
  
    def edit
      @movie = Movie.find params[:id]
    end
  
    def update
      @movie = Movie.find params[:id]
      @movie.update_attributes!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    end
  
    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      flash[:notice] = "Movie '#{@movie.title}' deleted."
      redirect_to movies_path
    end
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
  end