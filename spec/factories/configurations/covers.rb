FactoryBot.define do
  factory :cover, class: 'Configuration::Cover' do
    level { [ "Basic", "Standard", "Premium", "Elite" ].sample }
    multiplier { rand(0.8..2.0).round(2) }
  end

  trait :basic do
    level { "Basic" }
    multiplier { 1.0 }
  end

  trait :standard do
    level { "Standard" }
    multiplier { 1.5 }
  end

  trait :premium do
    level { "Premium" }
    multiplier { 2.0 }
  end
end
