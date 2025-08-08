module Premiums
  class Base < ApplicationService
    def initialize(claim)
      @claim = claim
    end

    private
    attr_accessor :claim

    def destination_multiplier
      highest_destination_zone&.multiplier || 0
    end

    def highest_destination_zone
      claim.destinations
        .map { |destination| destination.zone }
        .max_by(&:region_number)
    end
  end
end
