class EventsBatchCreator
  def create
    schedule_backoff_sending_job if events_batch.save
    events_batch
  end

  private

  # TODO: use timeout from .env
  def schedule_backoff_sending_job
    EventsBatchSendingJob.set(wait: 60.seconds).perform_later(events_batch.id)
  end

  def events_batch
    @events_batch ||= EventRecord.new(attributes)
  end
end
