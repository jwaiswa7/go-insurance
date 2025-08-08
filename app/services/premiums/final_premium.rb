module Premiums
  class FinalPremium < Base
    def call
      calculate_final_premium
    end

    private

    def calculate_final_premium
      claim.premiums.each do |premium|
        premium_amount = premium.base_amount.to_f *
                        cruise_multiplier(premium.base_amount.to_f) *
                        snow_multiplier(premium.base_amount.to_f)

        premium.update!(final_amount: premium_amount)
      end
    end

    def cruise_multiplier(base_premium)
      return 1.0 unless claim.has_cruise

      destination_multiplier
    end

    def snow_multiplier(base_premium)
      snow = claim.claim_snow
      return 1.0 unless snow.present?

      snow.snow_days * per_day_rate
    end

    def per_day_rate
      highest_destination_zone.snow.amount.to_f
    end
  end
end
