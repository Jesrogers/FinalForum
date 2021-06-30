FactoryBot.define do
  factory :forum_thread do
    sequence(:title) { |n| "Thread #{n}" }
    sequence(:body) { |n| "I am the body of the thread ##{n}" }
    association :forum
    association :author, factory: :user

    trait :with_replies do
      after(:create) { |forum_thread| create_list(:forum_reply, 2, forum_thread: forum_thread) }
    end
  end
end
