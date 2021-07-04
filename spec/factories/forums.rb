FactoryBot.define do
  factory :forum do
    sequence(:title) { |n| "Forum #{n}" }
    description { "Talk about whatever you want here" }
    association :channel

    trait :locked do
      locked { true }
    end

    trait :with_threads do
      after(:create) { |forum| create_list(:forum_thread, 2, forum: forum) }
    end
  end
end
