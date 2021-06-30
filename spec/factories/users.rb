FactoryBot.define do
  factory :user, aliases: [:author] do
    sequence(:email) { |n| "person#{n}@example.com" }
    sequence(:username) { |n| "person#{n}" }
    password { "verysecure" }
  end
end
