class EventsBatchSendingJob < ApplicationJob
  queue_as :default

  def perform(events_batch_id)
    events_batch = EventsBatch.find(events_batch_id)

    unless events_batch.delivered?
      EventsBatchSender.new(events_batch).send_batch
      events_batch.update(delivered: true)
    end
  end
end
