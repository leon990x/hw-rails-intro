class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      @all_ratings = Movie.ratings 
      #@ratings = params[:ratings] || session[:ratings] || {} 
      #@ratings =  Hash[@all_ratings.map {|rating| [rating, rating]}] #if @selected_ratings == {}
      @movies = Movie.where(rating: @ratings)
      @sort = params[:sort]
      @movies = Movie.all.order(@sort)
      
      if @sort
        @movies = @movies.where(rating: @ratings).order(@sort)
      else
        @movies = Movie.where(rating: @ratings)
      end
      
      # session[:ratings] = params[:ratings] if params[:ratings] || params[:commit] == 'Refresh'
      # session[:sort] = params[:sort] if params[:sort]
      # if (!params[:sort] && !params[:ratings]) && (session[:sort] && session[:ratings])
      #   flash.keep
      #   return redirect_to movies_path(sort: session[:sort], ratings: session[:ratings])
      # elsif !params[:sort] && session[:sort]
      #   flash.keep
      #   return redirect_to movies_path(sort: session[:sort], ratings: params[:ratings])
      # elsif !params[:ratings] && session[:ratings]
      #   flash.keep
      #   return redirect_to movies_path(sort: params[:sort], ratings: session[:ratings])
      # end
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