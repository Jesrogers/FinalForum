FactoryBot.define do
  factory :channel do
    name { "Employee Area" }

    trait :with_forums do
      after(:create) { |channel| create_list(:forum, 2, channel: channel) }
    end
  end
end
