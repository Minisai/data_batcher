class AvailableBatchPusher
  def push_event(event)
    available_batch.events << event
    enqueue_sending_job if available_batch.full?
  end

  private

  def available_batch
    @available_batch ||= begin
      EventsBatch.not_delivered.last || created_batch_record
    end
  end

  def enqueue_sending_job
    EventsBatchSendingJob.perform_later(available_batch.id)
  end

  def created_batch_record
    EventsBatchCreator.new.create
  end
end
