class EventRecord < ApplicationRecord
  validates :value, presence: true, uniqueness: true
end
