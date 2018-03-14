class EventRecord < ApplicationRecord
  validates :value, presence: true, uniqueness: true

  scope :not_delivered, -> { where(delivered: false) }
  scope :created_before, ->(created_before) { where('created_at <= ?', created_before) }
end
