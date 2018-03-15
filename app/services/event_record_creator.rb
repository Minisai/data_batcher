class EventRecordCreator
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def create
    push_to_events_batch if event_record.save
    event_record
  end

  private

  def push_to_events_batch
    AvailableBatchPusher.new.push_event(event_record)
  end

  def event_record
    @event_record ||= EventRecord.new(attributes)
  end
end
