FactoryBot.define do
  factory :user_zone do
    association :user
    association :hardiness_zone
  end
end
