require 'rails_helper'

RSpec.describe ClaimSnow, type: :model do
  describe "validations" do
    let!(:destination) { create(:destination) }
    let!(:claim) { create(:claim, destinations: [ destination ]) }

    it "is valid with valid attributes" do
      claim_snow = claim.build_claim_snow(
        start_date: claim.trip_start_date,
        end_date: claim.trip_end_date)
      expect(claim_snow).to be_valid
    end

    it "is not valid without a start date" do
      claim_snow = claim.build_claim_snow(
        start_date: nil,
        end_date: claim.trip_end_date)
      expect(claim_snow).to_not be_valid
    end

    it "is not valid without an end date" do
      claim_snow = claim.build_claim_snow(
        start_date: claim.trip_start_date,
        end_date: nil)
      expect(claim_snow).to_not be_valid
    end
  end
end
