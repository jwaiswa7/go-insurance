FactoryBot.define do
  factory :destination do
    country_code { Faker::Address.country_code }
    country { Faker::Address.country }
    association :zone, factory: :region
  end
end
