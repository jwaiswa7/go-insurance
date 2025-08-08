require "rails_helper"

RSpec.describe Premiums::FinalPremium do
  subject { described_class.call(claim.reload) }

  let!(:base_config) { create(:base_config) }
  let!(:region) { create(:region) }
  let!(:duration) { create(:duration, minimum: 3) }
  let!(:standard_cover) { create(:cover, :standard) }
  let!(:excess) { create(:excess, multiplier: 1.0) }
  let!(:scheme_type_one_way) { create(:scheme_type, one_way: true, multiplier: 1.0) }
  let!(:age) { create(:age, age: 16) }
  let!(:destination) { create(:destination, zone: region) }
  let!(:snow) { create(:snow, region: region, amount_cents: 10000) }

  let(:claim) do
    create(:claim,
      age: age,
      excess: excess,
      policy: Claim::POLICY_OPTIONS.first,
      trip_type: scheme_type_one_way,
      destinations: [ destination ],
      trip_start_date: Date.today,
      trip_end_date: Date.today + duration.minimum + 1.day
    )
  end

  before do
    Premiums::BasePremium.call(claim)
  end

  describe "#cruise_premium" do
    before do
      claim.update(has_cruise: true)
    end

    let(:standard_cruise_premium) do
      claim.premiums.find_by(cover: standard_cover)
    end

    let(:expected_amount) do
      standard_cruise_premium.base_amount.to_f * region.multiplier
    end

    it "calculates the cruise premium" do
      subject
      standard_cruise_premium.reload
      expect(standard_cruise_premium.final_amount.to_f).to eq(expected_amount.round(2).to_f)
    end
  end

  describe "#snow_premium" do
    before do
      claim.claim_snow = create(:claim_snow, claim: claim, start_date: claim.trip_start_date, end_date: claim.trip_end_date)
    end

    let(:standard_snow_premium) do
      claim.premiums.find_by(cover: standard_cover)
    end

    let(:expected_amount) do
      standard_snow_premium.base_amount.to_f * claim.claim_snow.snow_days * region.snow.amount.to_f
    end

    it "calculates the snow premium" do
      subject
      standard_snow_premium.reload
      expect(standard_snow_premium.final_amount.to_f).to eq(expected_amount.round(2).to_f)
    end
  end
end
