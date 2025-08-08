require 'rails_helper'

RSpec.describe Configuration::SchemeType, type: :model do
  it "is valid with valid attributes" do
    scheme_type = build(:scheme_type)
    expect(scheme_type).to be_valid
  end

  it "is not valid with a one_way that is not unique" do
    create(:scheme_type, one_way: true)
    scheme_type = build(:scheme_type, one_way: true)
    expect(scheme_type).to be_invalid
    expect(scheme_type.errors.full_messages).to include("One way has already been taken")
  end
end
