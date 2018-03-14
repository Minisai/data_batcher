class EventRecordCreator
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def create
    enqueue_batch_sending_job if event.save
    event
  end

  private

  def event
    @event ||= EventRecord.new(attributes)
  end

  def enqueue_batch_sending_job
    if delivered_count == 10
      EventsBatchSendingJob.perform_later(DateTime.current)
    end
  end

  def delivered_count
    @delivered_count ||= EventRecord.delivered.count
  end
end
