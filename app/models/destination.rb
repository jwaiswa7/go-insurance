class Destination < ApplicationRecord
  belongs_to :zone, class_name: "Configuration::Region"

  validates :country_code, :country, :zone, presence: true
  validates :country_code, :country, uniqueness: true

  def multiplier
    zone.multiplier
  end
end
