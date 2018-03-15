class EventsController < ApplicationController
  def create
    event_record = EventRecordCreator.new(value: params[:event]).create

    if event_record.valid?
      head :created
    else
      head :unprocessable_entity
    end
  end
end
