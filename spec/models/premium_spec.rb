require 'rails_helper'

RSpec.describe Premium, type: :model do
  it "is valid with valid attributes" do
    premium = build(:premium)
    expect(premium).to be_valid
  end

  it "is not valid without a claim" do
    premium = build(:premium, claim: nil)
  end
end
