class Age < ApplicationRecord
  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 98 }
  validates :age, uniqueness: true
  validates :multiplier, presence: true

  scope :valid, -> { where("age >= 16") }
end
