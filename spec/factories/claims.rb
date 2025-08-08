FactoryBot.define do
  factory :claim do
    association :trip_type, factory: :scheme_type
    association :age
    association :excess, factory: :excess
    trip_start_date { Faker::Date.between(from: Date.today, to: 6.months.from_now) }
    trip_end_date { |claim| Faker::Date.between(from: claim.trip_start_date, to: claim.trip_start_date + 30.days) }
    has_cruise { false }
    policy { Claim::POLICY_OPTIONS.sample }

    trait :with_cruise do
      has_cruise { true }
    end

    trait :with_snow do
      after(:create) do |claim|
        create(:claim_snow, claim: claim)
      end
    end

    trait :with_destinations do
      after(:build) do |claim|
        claim.claim_destinations << build_list(:claim_destination, rand(1..3), claim: claim)
      end
    end

    trait :complete do
      with_cruise
      with_snow
      with_destinations
      after(:create) do |claim|
        create(:premium, claim: claim)
      end
    end
  end
end
