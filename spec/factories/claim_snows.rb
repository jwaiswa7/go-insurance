FactoryBot.define do
  factory :claim_snow do
    claim
    start_date { |snow| snow.claim.trip_start_date }
    end_date { |snow| snow.claim.trip_end_date }
  end
end
