class Configuration::Cover < ApplicationRecord
  validates :level, presence: true
  validates :level, uniqueness: true
  validates :multiplier, presence: true, numericality: { greater_than: 0 }
end
