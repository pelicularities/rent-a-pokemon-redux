class Rental < ApplicationRecord
  belongs_to :pokemon
  belongs_to :user
  has_one :review
  validates :start_date, :end_date, presence: true

  # need some way to check if
  # 1. Pokemon is available
  # 2. end date is after start date
end
