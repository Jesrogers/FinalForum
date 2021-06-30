FactoryBot.define do
  factory :forum_reply do
    sequence(:body) { |n| "I am awesome forum reply #{n}" }

    association :forum_thread
    association :author, factory: :user
  end
end
