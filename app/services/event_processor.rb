class EventProcessor
  attr_reader :event

  def initialize(event)
    @event = event
  end

  def process
    push_to_available_batch if event_record.valid?
    event_record.valid?
  end

  private

  def push_to_available_batch
    AvailableBatchPusher.new.push_event(event_record)
  end

  def event_record
    @event_record ||= EventRecord.new(value: event)
  end
end
