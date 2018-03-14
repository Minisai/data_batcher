class EventsBatchSendingJob < ApplicationJob
  queue_as :default

  def perform(created_before)
    @created_before = created_before

    EventsBatchSender.new(event_records).send_batch if event_records.any?

    schedule_backoff_sending_job
  end

  private

  def schedule_backoff_sending_job
    #TODO: use backoff from env variables
    EventsBatchSendingJob.set(wait: 60.seconds).perform_later(DateTime.current + 60.seconds)
  end

  def event_records
    @event_records ||= begin
      EventRecord.not_delivered.created_before(created_before).order(:created_at).limit(10)
    end
  end
end
