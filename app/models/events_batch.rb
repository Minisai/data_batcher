class EventsBatch < ApplicationRecord
  has_many :event_records
  scope :not_delivered, -> { where(delivered: false) }

  # TODO: batch_limit .env variable
  def full?
    event_records_count == 10
  end
end
