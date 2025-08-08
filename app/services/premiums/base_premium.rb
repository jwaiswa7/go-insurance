module Premiums
  class BasePremium < Base
    def call
      calculate_premiums
    end

    private

    def calculate_premiums
      base_premium_per_cover if claim.premiums.blank?
    end

    def covers
      @covers ||= Configuration::Cover.all
    end

    def base_premium_per_cover
      covers.map do |cover|
        premium = base_premium * cover.multiplier
        Premium.create!(
          claim: claim,
          cover: cover,
          base_amount: premium,
          final_amount: premium
        )
      end
    end

    def base_premium
      @base_premium ||= base_number * claim.excess.multiplier * claim.age.multiplier * duration_multiplier * destination_multiplier * trip_type_multiplier
    end

    def base_number
      Configuration::BaseConfig.first.base_number
    end

    def duration_multiplier
      @duration_multiplier ||= Configuration::Duration.less_than(
        claim.trip_end_date - claim.trip_start_date
      ).last&.multiplier || 0
    end

    def trip_type_multiplier
      @trip_type_multiplier ||= claim.trip_type.multiplier
    end
  end
end
