require 'rails_helper'

RSpec.describe ClaimDestination, type: :model do
  it "is valid with valid attributes" do
    claim_destination = build(:claim_destination)

    expect(claim_destination).to be_valid
  end
end
