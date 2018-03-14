class EventsController < ApplicationController
  def create
    event = EventRecord.new(value: params[:event])

    if event.save
      head :created
    else
      head :unprocessable_entity
    end
  end
end
