FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "shepherd_smith_#{n}@example.com" }
    password { SecureRandom.alphanumeric(12) }
    confirmed_at { Time.current }
  end
end
