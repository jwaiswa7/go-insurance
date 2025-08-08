class ClaimSnow < ApplicationRecord
  belongs_to :claim

  validates :start_date, :end_date, presence: true

  validate :end_date_is_after_start_date
  validate :start_date_is_after_claim_start_date
  validate :end_date_is_before_claim_end_date

  def snow_days
    (end_date - start_date).to_i + 1
  end

  private

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end

  def start_date_is_after_claim_start_date
    return if start_date.blank? || claim.trip_start_date.blank?

    if start_date < claim.trip_start_date
      errors.add(:start_date, "must be after claim start date")
    end
  end

  def end_date_is_before_claim_end_date
    return if end_date.blank? || claim.trip_end_date.blank?

    if end_date > claim.trip_end_date
      errors.add(:end_date, "must be before claim end date")
    end
  end
end
