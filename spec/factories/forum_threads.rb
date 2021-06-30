FactoryBot.define do
  factory :forum_thread do
    sequence(:title) { |n| "Thread #{n}" }
    sequence(:body) { |n| "I am the body of the thread ##{n}" }
    association :forum
    association :author, factory: :user
  end
end
