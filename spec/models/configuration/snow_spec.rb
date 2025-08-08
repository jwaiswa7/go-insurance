require 'rails_helper'

RSpec.describe Configuration::Snow, type: :model do
  it "is valid with valid attributes" do
    snow = build(:snow)
    expect(snow).to be_valid
  end

  it "is not valid without an amount_cents" do
    snow = build(:snow, amount_cents: nil)
    expect(snow).to be_invalid
    expect(snow.errors.full_messages).to include("Amount cents can't be blank")
  end

  it "is not valid with an amount_cents less than 0" do
    snow = build(:snow, amount_cents: 0)
    expect(snow).to be_invalid
    expect(snow.errors.full_messages).to include("Amount cents must be greater than 0")
  end

  it "is not valid without a region" do
    snow = build(:snow, region: nil)
    expect(snow).to be_invalid
    expect(snow.errors.full_messages).to include("Region can't be blank")
  end
end
