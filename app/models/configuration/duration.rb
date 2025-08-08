class Configuration::Duration < ApplicationRecord
  validates :minimum, :multiplier, presence: true
  validates :minimum, uniqueness: true
  validates :minimum, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :less_than, ->(value) { where("minimum <= ?", value) }
end
