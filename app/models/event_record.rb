class EventRecord < ApplicationRecord
  validates :value, presence: true, uniqueness: true

  belongs_to :events_batch, inverse_of: :event_records, optional: true

  scope :without_batch, -> { where(events_batch_id: nil) }
end
