class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    new_director = Director.new

    new_director.name = params.fetch("name")
    new_director.dob = params.fetch("dob")
    new_director.bio = params.fetch("bio")
    new_director.image = params.fetch("image")

    new_director.save

    redirect_to("/directors")
  end

  def destroy
    director_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => director_id  })
    the_director = matching_directors.first 
    the_director.destroy

    redirect_to("/directors")
  end

  def update
    director_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => director_id })
    the_director = matching_directors.first

    the_director.name = params.fetch("name")
    the_director.dob = params.fetch("dob")
    the_director.bio = params.fetch("bio")
    the_director.image = params.fetch("image")

    the_director.save

    redirect_to("/directors/#{the_director.id}")
  end
end
