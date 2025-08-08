FactoryBot.define do
  factory :cruise, class: 'Configuration::Cruise' do
    association :region, factory: :region
    amount_cents { rand(10000..50000) }
    amount_currency { "USD" }
  end
end
