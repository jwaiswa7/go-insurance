require 'rails_helper'

RSpec.describe Claim, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      claim = build(:claim, :with_destinations)
      expect(claim).to be_valid
    end

    it "is not valid with a start date in the past" do
      claim = build(
        :claim,
        :with_destinations,
        trip_start_date: 1.day.ago
      )

      expect(claim).to be_invalid
      expect(claim.errors.full_messages).to include("Start date cannot be in the past")
    end

    it "is not valid with an end date in the past" do
      claim = build(:claim, :with_destinations, trip_end_date: 1.day.ago)
      expect(claim).to be_invalid
      expect(claim.errors.full_messages).to include("End date cannot be in the past")
    end

    it "is not valid with a start date after the end date" do
      claim = build(
        :claim,
        :with_destinations,
        trip_start_date: 1.day.from_now,
        trip_end_date: 1.day.ago
      )

      expect(claim).to be_invalid
      expect(claim.errors.full_messages).to include("Start date cannot be after end date")
    end

    it "is not valid with a end date more than 2 years after the start date" do
      claim = build(
        :claim,
        :with_destinations,
        trip_start_date: Date.today,
        trip_end_date: Date.today + 2.years
      )

      expect(claim).to be_invalid
      expect(claim.errors.full_messages).to include("End date cannot be more than 2 years after start date")
    end

    it "is not valid with a start date more than 18 months from today for single trip" do
      claim = build(
        :claim,
        :with_destinations,
        trip_start_date: 18.months.from_now,
        policy: "Single Trip"
      )

      expect(claim).to be_invalid
      expect(claim.errors.full_messages).to include("Start date cannot be more than 18 months from today")
    end

    it "is not valid with a start date more than 12 months from today for multi trip" do
      claim = build(
        :claim,
        :with_destinations,
        trip_start_date: 12.months.from_now,
        policy: "Multi Trip"
      )

      expect(claim).to be_invalid
      expect(claim.errors.full_messages).to include("Start date cannot be more than 12 months from today")
    end

    it "is not valid with invalid policy" do
      claim = build(:claim, :with_destinations, policy: "Invalid Policy")
      expect(claim).to be_invalid
      expect(claim.errors.full_messages).to include("Policy is not included in the list")
    end
  end

  describe "minimum duration" do
    let(:minimum_duration) { 10 }

    before do
      create(:duration, minimum: minimum_duration)
    end

    it "is valid with a end date and start date that is more than the minimum duration" do
      claim = build(
        :claim,
        :with_destinations,
        trip_start_date: Date.today,
        trip_end_date: Date.today + minimum_duration + 1.day
      )

      expect(claim).to be_valid
    end

    it "is not valid with a end date and start date that is less than the minimum duration" do
      claim = build(
        :claim,
        :with_destinations,
        trip_start_date: Date.today,
        trip_end_date: Date.today + minimum_duration - 1.day
      )

      expect(claim).to be_invalid
      expect(claim.errors.full_messages).to include("End date cannot be less than #{minimum_duration} days")
    end
  end

  describe "age" do
    let(:below_16) { create(:age, age: 15) }
    let(:above_16) { create(:age, age: 16) }

    before do
      below_16
      above_16
    end

    it "is valid with an age greater than 16" do
      claim = build(:claim, :with_destinations, age: above_16)
      expect(claim).to be_valid
    end

    it "is not valid with an age less than 16" do
      claim = build(:claim, :with_destinations, age: below_16)
      expect(claim).to be_invalid
      expect(claim.errors.full_messages).to include("Age cannot be less than 16")
    end
  end
end
