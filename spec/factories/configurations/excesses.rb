FactoryBot.define do
  factory :excess, class: 'Configuration::Excess' do
    excess_cents { [ 5000, 10000, 15000, 20000 ].sample }
    excess_currency { "USD" }
    multiplier { rand(0.8..1.2).round(2) }

    trait :low do
      excess_cents { 5000 }
      multiplier { 1.2 }
    end

    trait :standard do
      excess_cents { 10000 }
      multiplier { 1.0 }
    end

    trait :high do
      excess_cents { 20000 }
      multiplier { 0.8 }
    end
  end
end
