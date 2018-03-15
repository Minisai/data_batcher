class EventsBatch < ApplicationRecord
  has_many :event_records
  scope :not_delivered, -> { where(delivered: false) }

  def full?
    event_records_count == ENV['EVENTS_BATCH_LIMIT']
  end
end
