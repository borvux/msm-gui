class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    # create a new actor record
    create_new_actor = Actor.new

    # fetch the params and put it into the record
    create_new_actor.name = params.fetch("the_name")
    create_new_actor.dob = params.fetch("the_dob")
    create_new_actor.bio = params.fetch("the_bio")
    create_new_actor.image = params.fetch("the_image")

    # save the records
    create_new_actor.save

    redirect_to("/actors")
  end

  def destroy
    the_id = params.fetch("path_id")

    matching_movies = Actor.where({ :id => the_id })
    the_actor = matching_movies.at(0)
    the_actor.destroy
    redirect_to("/actors")
  end

  def update
    # get the params of the id
    the_id = params.fetch("path_id")

    # find the actor records using the id 
    matching_actors = Movie.where({ :id => the_id })
    update_actors = matching_actors.at(0)

    # update the informations
    update_actors.name = params.fetch("the_name")
    update_actors.dob = params.fetch("the_dob")
    update_actors.bio = params.fetch("the_bio")
    update_actors.image = params.fetch("the_image")

    # save the informations
    update_actors.save

    # redirect back to the page
    redirect_to("/actors/#{update_actors.id}")
  end
end
