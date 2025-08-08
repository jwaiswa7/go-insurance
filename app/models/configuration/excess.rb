class Configuration::Excess < ApplicationRecord
  monetize :excess_cents, as: :excess

  validates :excess_cents, :multiplier, presence: true
  validates :excess_cents, uniqueness: true
  validates :multiplier, numericality: { greater_than: 0 }
end
