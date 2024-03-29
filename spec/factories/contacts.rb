FactoryBot.define do
  factory :contact do
    sequence(:name) { |n| "Jane Doe #{n}" }
    sequence(:email) { |n| "jane_doe_#{n}@example.com" }
    user
  end
end
