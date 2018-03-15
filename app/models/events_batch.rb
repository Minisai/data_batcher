class EventsBatch < ApplicationRecord
  has_many :event_records, inverse_of: :events_batch
  scope :not_delivered, -> { where(delivered: false) }

  def full?
    event_records.count == ENV['EVENTS_BATCH_LIMIT'].to_i
  end
end
