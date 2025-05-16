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
    new_actor = Actor.new

    new_actor.name = params.fetch("name")
    new_actor.dob = params.fetch("dob")
    new_actor.bio = params.fetch("bio")
    new_actor.image = params.fetch("image")

    new_actor.save

    redirect_to("/actors")
  end

  def destroy
    actor_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => actor_id })
    the_actor = matching_actors.first # or .at(0)
    the_actor.destroy

    redirect_to("/actors")
  end

  def update
    actor_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => actor_id })
    the_actor = matching_actors.first

    the_actor.name = params.fetch("name")
    the_actor.dob = params.fetch("dob")
    the_actor.bio = params.fetch("bio")
    the_actor.image = params.fetch("image")

    the_actor.save

    redirect_to("/actors/#{the_actor.id}")
  end
end
