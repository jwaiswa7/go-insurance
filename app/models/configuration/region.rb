class Configuration::Region < ApplicationRecord
  has_many :cruises, class_name: "Configuration::Cruise", dependent: :destroy
  has_one :snow, class_name: "Configuration::Snow", dependent: :destroy
  has_many :destinations, dependent: :destroy

  validates :region_number, :multiplier, presence: true
  validates :region_number, uniqueness: true
  validates :region_number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :multiplier, numericality: { greater_than: 0 }
end
