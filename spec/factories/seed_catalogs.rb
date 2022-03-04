FactoryBot.define do
  factory :seed_catalog do
    planted { false }

    association :user
    association :seed
  end
end
