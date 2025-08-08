require 'rails_helper'

RSpec.describe Destination, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:country_code) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:zone) }

    it "validates country_code is unique" do
      create(:destination, country_code: 'US')
      expect(build(:destination, country_code: 'US')).to be_invalid
    end

    it "validates country is unique" do
      create(:destination, country: 'United States')
      expect(build(:destination, country: 'United States')).to be_invalid
    end
  end
end
