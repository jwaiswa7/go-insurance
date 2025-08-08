FactoryBot.define do
  factory :scheme_type, class: 'Configuration::SchemeType' do
    one_way { [ true, false ].sample }
    multiplier { 1.0 }

    trait :one_way do
      one_way { true }
      multiplier { 0.6 }
    end

    trait :return do
      one_way { false }
      multiplier { 1.0 }
    end
  end
end
