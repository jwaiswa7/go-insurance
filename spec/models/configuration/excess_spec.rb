require 'rails_helper'

RSpec.describe Configuration::Excess, type: :model do
  it "is valid with valid attributes" do
    excess = build(:excess)
    expect(excess).to be_valid
  end

  it "is not valid without a excess_cents" do
    excess = build(:excess, excess_cents: nil)
    expect(excess).to be_invalid
    expect(excess.errors.full_messages).to include("Excess cents can't be blank")
  end

  it "is not valid with a excess_cents that is not unique" do
    create(:excess, excess_cents: 5000)
    excess = build(:excess, excess_cents: 5000)
    expect(excess).to be_invalid
    expect(excess.errors.full_messages).to include("Excess cents has already been taken")
  end

  it "is not valid without a multiplier" do
    excess = build(:excess, multiplier: nil)
    expect(excess).to be_invalid
    expect(excess.errors.full_messages).to include("Multiplier can't be blank")
  end
end
