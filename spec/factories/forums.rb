FactoryBot.define do
  factory :forum do
    sequence(:title) { |n| "Forum #{n}" }
    description { "Talk about whatever you want here" }
    association :channel
  end
end
