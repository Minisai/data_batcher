FactoryBot.define do
  factory :event_record do
    sequence(:value) { |n| "event#{n}" }
  end
end
