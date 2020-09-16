class Rental < ApplicationRecord
  belongs_to :pokemon
  belongs_to :user
  has_one :review

  # validation code for start and end dates
  # adapted from: 
  # https://medium.com/lightthefuse/ruby-on-rails-date-validation-in-a-booking-and-disabling-dates-in-date-picker-3e5b4e9b4640
  validates :start_date, :end_date, presence: true, availability: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?
    
    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
