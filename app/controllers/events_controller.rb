class EventsController < ApplicationController
  def create
    @age = Age.find_or_create_by(days: params[:days])

    @age.events.build(event_params)

    if @age.save
      all_ages = Age.order(days: :asc)
      render json: all_ages, include: :events
    else
      render json: {
        error: @age.errors.full_messages,
        status: 400
      }, status: 400
    end
  end

  def all_records
    @ages = Age.order(days: :asc)
    render json: @ages, include: :events
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :days)
  end
end
