FactoryBot.define do
  factory :snow, class: 'Configuration::Snow' do
    association :region, factory: :region
    amount_cents { rand(10000..30000) }
    amount_currency { "USD" }
  end
end
