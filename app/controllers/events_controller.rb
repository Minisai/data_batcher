class EventsController < ApplicationController
  def create
    if EventProcessor.new(params[:event]).process
      head :created
    else
      head :unprocessable_entity
    end
  end
end
