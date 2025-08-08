FactoryBot.define do
  factory :duration, class: 'Configuration::Duration' do
    minimum { [ 7, 14, 21, 28 ].sample }
    multiplier { rand(0.8..2.0).round(2) }

    trait :one_week do
      minimum { 7 }
      multiplier { 1.0 }
    end

    trait :two_weeks do
      minimum { 14 }
      multiplier { 1.2 }
    end

    trait :three_weeks do
      minimum { 21 }
      multiplier { 1.4 }
    end

    trait :four_weeks do
      minimum { 28 }
      multiplier { 1.6 }
    end
  end
end
