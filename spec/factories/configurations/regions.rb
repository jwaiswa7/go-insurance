FactoryBot.define do
  factory :region, class: 'Configuration::Region' do
    region_number { rand(1..5) }
    multiplier { rand(0.8..2.0).round(2) }

    trait :europe do
      region_number { 1 }
      multiplier { 1.0 }
    end

    trait :worldwide_excl_usa do
      region_number { 2 }
      multiplier { 1.5 }
    end

    trait :worldwide do
      region_number { 3 }
      multiplier { 2.0 }
    end
  end
end
