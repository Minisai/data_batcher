class EventRecord < ApplicationRecord
  validates :value, presence: true, uniqueness: true

  belongs_to :events_batch, inverse_of: :event_records, counter_cache: true, optional: true
end
