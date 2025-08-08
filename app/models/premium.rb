class Premium < ApplicationRecord
  self.table_name = "premiums"

  monetize :base_amount_cents
  monetize :final_amount_cents

  belongs_to :claim
  belongs_to :cover, class_name: "Configuration::Cover"
end
