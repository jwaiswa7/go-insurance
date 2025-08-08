require 'rails_helper'

RSpec.describe Age, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:age) }
    it { is_expected.to validate_presence_of(:multiplier) }

    it "validates age is unique" do
      create(:age, age: 10)
      expect(build(:age, age: 10)).to be_invalid
    end

    it "validates age below 99" do
      expect(build(:age, age: 100)).to be_invalid
    end

    it "validates age above 0" do
      expect(build(:age, age: -1)).to be_invalid
    end
  end
end
