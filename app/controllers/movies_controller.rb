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
    # create a new movie record
    create_new_movie = Movie.new

    # fetch the params and put it into the record
    create_new_movie.title = params.fetch("the_title")
    create_new_movie.year = params.fetch("the_year")
    create_new_movie.duration = params.fetch("the_duration")
    create_new_movie.description = params.fetch("the_description")
    create_new_movie.image = params.fetch("the_image")
    create_new_movie.director_id = params.fetch("the_director_id")

    # save the records
    create_new_movie.save

    redirect_to("/movies")
  end

  def destroy
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    the_movie = matching_movies.at(0)
    the_movie.destroy
    redirect_to("/movies")
  end

  def update
    # get the params of the id
    the_id = params.fetch("path_id")

    # find the movie records using the id 
    matching_movies = Movie.where({ :id => the_id })
    update_movie = matching_movies.at(0)

    # update the informations
    update_movie.title = params.fetch("the_title")
    update_movie.year = params.fetch("the_year")
    update_movie.duration = params.fetch("the_duration")
    update_movie.description = params.fetch("the_description")
    update_movie.image = params.fetch("the_image")
    update_movie.director_id = params.fetch("the_director_id")

    # save the informations
    update_movie.save

    # redirect back to the page
    redirect_to("/movies/#{update_movie.id}")
  end
end
