class EventRecord < ApplicationRecord
  validates :value, presence: true, uniqueness: true

  belongs_to :events_batch, counter_cache: true

  scope :without_batch, -> { where(events_batch_id: nil) }
end
