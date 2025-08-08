class Configuration::BaseConfig < ApplicationRecord
  validates :base_number, presence: true
  validates :base_number, uniqueness: true
end
