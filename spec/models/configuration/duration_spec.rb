require 'rails_helper'

RSpec.describe Configuration::Duration, type: :model do
  it "is valid with valid attributes" do
    duration = build(:duration)
    expect(duration).to be_valid
  end

  it "is not valid without a minimum" do
    duration = build(:duration, minimum: nil)
    expect(duration).to be_invalid
    expect(duration.errors.full_messages).to include("Minimum can't be blank")
  end

  it "is not valid with a minimum that is not unique" do
    create(:duration, minimum: 10)
    duration = build(:duration, minimum: 10)
    expect(duration).to be_invalid
    expect(duration.errors.full_messages).to include("Minimum has already been taken")
  end

  it "is not valid without a multiplier" do
    duration = build(:duration, multiplier: nil)
    expect(duration).to be_invalid
    expect(duration.errors.full_messages).to include("Multiplier can't be blank")
  end
end
