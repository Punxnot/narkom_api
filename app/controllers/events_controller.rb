class EventsController < ApplicationController
  def create
    @age = Age.find_or_create_by(days: params[:days])

    @age.events.build(event_params)

    if @age.save
      # flash[:notice] = "Successfully created event."
      render json: @age, include: :events
    else
      render json: {
        error: @age.errors.full_messages,
        status: 400
      }, status: 400
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :days)
  end
end
