class Configuration::SchemeType < ApplicationRecord
  validates :multiplier, presence: true
  validates :multiplier, numericality: { greater_than: 0 }
  validates :one_way, inclusion: { in: [ true, false ] }
  validates :one_way, uniqueness: true
end
