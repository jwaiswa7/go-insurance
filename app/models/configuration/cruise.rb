class Configuration::Cruise < ApplicationRecord
  include Multipliable

  belongs_to :region, class_name: "Configuration::Region"

  monetize :amount_cents

  validates :amount_cents, presence: true
end
