require "rails_helper"

RSpec.describe Premiums::BasePremium do
  subject { described_class.call(claim) }

  let!(:base_config) { create(:base_config) }
  let!(:region) { create(:region, region_number: 1) }
  let!(:region_2) { create(:region, region_number: 2) }
  let!(:duration) { create(:duration, minimum: 3) }
  let!(:basic_cover) { create(:cover, :basic) }
  let!(:standard_cover) { create(:cover, :standard) }
  let!(:premium_cover) { create(:cover, :premium) }
  let!(:excess) { create(:excess, multiplier: 1.0) }
  let!(:scheme_type_one_way) { create(:scheme_type, one_way: true, multiplier: 1.0) }
  let!(:age) { create(:age, age: 16) }
  let!(:destination) { create(:destination, zone: region) }
  let!(:destination_2) { create(:destination, zone: region_2) }
  let(:number_of_covers) { Configuration::Cover.count }

  let(:claim) do
    create(:claim,
      age: age,
      excess: excess,
      policy: Claim::POLICY_OPTIONS.first,
      trip_type: scheme_type_one_way,
      destinations: [ destination, destination_2 ],
      trip_start_date: Date.today,
      trip_end_date: Date.today + duration.minimum + 1.day
    )
  end


  describe "#call" do
    it "creates a base premium" do
      claim.reload
      expect { subject }.to change(claim.premiums, :count).by(number_of_covers)
    end
  end

  describe "premiums" do
    before do
      subject
    end

    let(:base_premium_calculation) do
      base_config.base_number *
        excess.multiplier *
        age.multiplier *
        duration.multiplier *
        region_2.multiplier *
        scheme_type_one_way.multiplier *
        basic_cover.multiplier
    end

    let(:base_premium_calculation_standard) do
      base_config.base_number *
        excess.multiplier *
        age.multiplier *
        duration.multiplier *
        region_2.multiplier *
        scheme_type_one_way.multiplier *
        standard_cover.multiplier
    end

    let(:base_premium_calculation_premium) do
      base_config.base_number *
        excess.multiplier *
        age.multiplier *
        duration.multiplier *
        region_2.multiplier *
        scheme_type_one_way.multiplier *
        premium_cover.multiplier
    end

    it "has the correct base amount" do
      claim.reload

      base_premium = claim.premiums.where(cover: basic_cover).first
      expect(base_premium.base_amount.to_f).to eq(base_premium_calculation.round(2))
    end

    it "has the correct base amount for standard cover" do
      claim.reload

      base_premium = claim.premiums.where(cover: standard_cover).first
      expect(base_premium.base_amount.to_f).to eq(base_premium_calculation_standard.round(2))
    end

    it "has the correct base amount for premium cover" do
      claim.reload

      base_premium = claim.premiums.where(cover: premium_cover).first
      expect(base_premium.base_amount.to_f).to eq(base_premium_calculation_premium.round(2))
    end
  end
end
