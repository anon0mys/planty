FactoryBot.define do
  factory :hardiness_zone do
    zipcode { Faker::Address.zip_code }
    zone { '5b' }
    trange { '-15 to -10' }
    zonetitle { '5b: -15 to -10' }
  end
end
