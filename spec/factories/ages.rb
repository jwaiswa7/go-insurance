FactoryBot.define do
  factory :age do
    age { rand(18..85) }
    multiplier { rand(0.8..2.0).round(2) }
  end
end
