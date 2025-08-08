require 'rails_helper'

RSpec.describe Configuration::BaseConfig, type: :model do
  it "is valid with valid attributes" do
    base_config = build(:base_config)
    expect(base_config).to be_valid
  end

  it "is not valid with a base number less than 1" do
    base_config = build(:base_config, base_number: nil)
    expect(base_config).to be_invalid
    expect(base_config.errors.full_messages).to include("Base number can't be blank")
  end
end
