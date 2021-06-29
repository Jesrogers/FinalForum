FactoryBot.define do
  factory :channel do
    name { "Employee Area" }
    position { 1 }

    trait :with_forums do
      after(:create) { |channel| create_list(:forum, 2, channel: channel) }
    end
  end
end
