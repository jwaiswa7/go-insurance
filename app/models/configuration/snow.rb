class Configuration::Snow < ApplicationRecord
  include Multipliable

  belongs_to :region, class_name: "Configuration::Region"

  monetize :amount_cents
  validates :region, presence: true
  validates :amount_cents, presence: true
  validates :amount_cents, numericality: { greater_than: 0 }
end
