class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
    new_movie = Movie.new

    new_movie.title = params.fetch("title")
    new_movie.year = params.fetch("year")
    new_movie.duration = params.fetch("duration")
    new_movie.description = params.fetch("description")
    new_movie.image = params.fetch("image")
    new_movie.director_id = params.fetch("director_id")

    new_movie.save

    redirect_to("/movies")
  end

  def destroy
    movie_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => movie_id  })
    the_movie = matching_movies.first 
    the_movie.destroy

    redirect_to("/movies")
  end

  def update
    movie_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => movie_id })
    the_movie = matching_movies.first

    the_movie.title = params.fetch("title")
    the_movie.year = params.fetch("year")
    the_movie.duration = params.fetch("duration")
    the_movie.description = params.fetch("description")
    the_movie.image = params.fetch("image")
    the_movie.director_id = params.fetch("director_id")

    the_movie.save

    redirect_to("/movies/#{the_movie.id}")
  end
end
