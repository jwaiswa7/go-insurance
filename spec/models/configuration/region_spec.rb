require 'rails_helper'

RSpec.describe Configuration::Region, type: :model do
  it "is valid with valid attributes" do
    region = build(:region)
    expect(region).to be_valid
  end

  it "is not valid without a multiplier" do
    region = build(:region, multiplier: nil)
    expect(region).to be_invalid
    expect(region.errors.full_messages).to include("Multiplier can't be blank")
  end

  it "is not valid with a multiplier less than 0" do
    region = build(:region, multiplier: 0)
    expect(region).to be_invalid
    expect(region.errors.full_messages).to include("Multiplier must be greater than 0")
  end

  it "is not valid with a region_number that is not unique" do
    create(:region, region_number: 1)
    region = build(:region, region_number: 1)
    expect(region).to be_invalid
  end
end
