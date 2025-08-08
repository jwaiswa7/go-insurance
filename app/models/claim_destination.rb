class ClaimDestination < ApplicationRecord
  belongs_to :claim
  belongs_to :destination
end
