class EventsBatchCreator
  def create
    schedule_backoff_sending_job if events_batch.save
    events_batch
  end

  private

  def schedule_backoff_sending_job
    EventsBatchSendingJob.set(wait: ENV['BACKOFF_DURATION'].to_i.seconds).perform_later(events_batch.id)
  end

  def events_batch
    @events_batch ||= EventsBatch.new
  end
end
