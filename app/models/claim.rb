
class Claim < ApplicationRecord
  attr_accessor :destination_ids
  POLICY_OPTIONS = [ "Single Trip", "Multi Trip" ].freeze

  belongs_to :trip_type, class_name: "Configuration::SchemeType"
  belongs_to :age
  belongs_to :excess, class_name: "Configuration::Excess"

  has_many :claim_destinations, dependent: :destroy
  has_many :destinations, through: :claim_destinations
  has_many :premiums, dependent: :destroy

  has_one :claim_snow, dependent: :destroy

  accepts_nested_attributes_for :claim_snow, allow_destroy: true, reject_if: :dates_are_blank

  before_update :update_premiums_if_has_cruise_changed

  validates :policy, inclusion: { in: POLICY_OPTIONS }

  def initialize(attributes = {})
    super(attributes)
    self.policy ||= POLICY_OPTIONS.first
  end

  validate :age_is_not_less_than_16
  validate :start_date_is_not_in_the_past, on: :create
  validate :end_date_is_not_in_the_past, on: :create
  validate :start_date_is_before_end_date
  validate :end_date_is_not_less_than_minimum_duration
  validate :end_date_is_not_more_than_2_years_after_start_date
  validate :start_date_is_not_more_than_18_months_from_today_for_single_trip
  validate :start_date_is_not_more_than_12_months_from_today_for_multi_trip
  validate :has_destinations

  private

  def has_destinations
    if claim_destinations.empty?
      errors.add(:base, "must have at least one destination")
    end
  end

  def age_is_not_less_than_16
    if age.present? && age.age < 16
      errors.add(:age, "cannot be less than 16")
    end
  end

  def update_premiums_if_has_cruise_changed
    if saved_change_to_has_cruise?
      puts "update_premiums_if_has_cruise_changed"
      Premiums::FinalPremium.call(self)
    end
  end

  def start_date_is_not_in_the_past
    if trip_start_date.present? && trip_start_date < Date.today
      errors.add(:start_date, "cannot be in the past")
    end
  end

  def end_date_is_not_in_the_past
    if trip_end_date.present? && trip_end_date < Date.today
      errors.add(:end_date, "cannot be in the past")
    end
  end

  def start_date_is_before_end_date
    if trip_start_date.present? && trip_end_date.present? && trip_start_date > trip_end_date
      errors.add(:start_date, "cannot be after end date")
    end
  end

  def end_date_is_not_less_than_minimum_duration
    min_duration = Configuration::Duration.order(:minimum).first&.minimum
    return if min_duration.blank? || trip_start_date.blank? || trip_end_date.blank?

    date_diff = (trip_end_date - trip_start_date).to_i
    if date_diff < min_duration
      errors.add(:end_date, "cannot be less than #{min_duration} days")
    end
  end

  def start_date_is_not_more_than_18_months_from_today_for_single_trip
    return if policy == "Multi Trip"
    if trip_start_date.present? && trip_start_date >= Date.today + 18.months
      errors.add(:start_date, "cannot be more than 18 months from today")
    end
  end

  def start_date_is_not_more_than_12_months_from_today_for_multi_trip
    return if policy == "Single Trip"
    if trip_start_date.present? && trip_start_date >= Date.today + 12.months
      errors.add(:start_date, "cannot be more than 12 months from today")
    end
  end

  def end_date_is_not_more_than_2_years_after_start_date
    return if trip_end_date.blank? || trip_start_date.blank?
    if trip_end_date >= trip_start_date + 2.years
      errors.add(:end_date, "cannot be more than 2 years after start date")
    end
  end

  def dates_are_blank(attributes)
    attributes["start_date"].blank? && attributes["end_date"].blank?
  end
end
