FactoryBot.define do
  factory :base_config, class: 'Configuration::BaseConfig' do
    base_number { rand(0.1..1.0).round(15) }
  end
end
