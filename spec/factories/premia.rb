FactoryBot.define do
  factory :premium do
    claim
    association :cover, factory: :cover
    base_amount_cents { rand(5000..50000) }
    base_amount_currency { "USD" }
    final_amount_cents { |premium| (premium.base_amount_cents * rand(1.1..1.5)).to_i }
    final_amount_currency { "USD" }
  end
end
