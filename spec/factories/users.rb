FactoryBot.define do
  factory :user, aliases: [:author] do
    sequence(:email) { |n| "person#{n}@example.com" }
    sequence(:username) { |n| "person#{n}" }
    password { "verysecure" }

    trait :with_threads do
      after(:create) { |user| create_list(:forum_thread, 2, author: user) }
    end
  end
end
