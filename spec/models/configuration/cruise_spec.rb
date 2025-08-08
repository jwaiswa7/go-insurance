require 'rails_helper'

RSpec.describe Configuration::Cruise, type: :model do
  it "is valid with valid attributes" do
    cruise = build(:cruise)
    expect(cruise).to be_valid
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:amount_cents) }
  end
end
