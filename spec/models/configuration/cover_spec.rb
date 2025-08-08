require 'rails_helper'

RSpec.describe Configuration::Cover, type: :model do
  it "is valid with valid attributes" do
    cover = build(:cover)
    expect(cover).to be_valid
  end

  it "is not valid without a level" do
    cover = build(:cover, level: nil)
    expect(cover).to be_invalid
    expect(cover.errors.full_messages).to include("Level can't be blank")
  end

  it "is not valid with a level that is not unique" do
    create(:cover, level: "Basic")
    cover = build(:cover, level: "Basic")
    expect(cover).to be_invalid
    expect(cover.errors.full_messages).to include("Level has already been taken")
  end

  it "is not valid without a multiplier" do
    cover = build(:cover, multiplier: nil)
    expect(cover).to be_invalid
    expect(cover.errors.full_messages).to include("Multiplier can't be blank")
  end

  it "is not valid with a multiplier less than 0" do
    cover = build(:cover, multiplier: 0)
    expect(cover).to be_invalid
    expect(cover.errors.full_messages).to include("Multiplier must be greater than 0")
  end
end
