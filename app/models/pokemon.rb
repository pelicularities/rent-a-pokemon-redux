class Pokemon < ApplicationRecord
  belongs_to :user
  belongs_to :pokedex
  has_many :rentals, dependent: :destroy
  has_many :reviews, through: :rentals
  validates :name, :description, :price, :location, presence: true

  def unavailable_dates
    rentals.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end

  def avg_rating
    # avg rating is out of 5, rounded to nearest half
    (reviews.map { |review| review.rating }.reduce(:+).fdiv(reviews.length) * 2).round.fdiv(2)
  end
end
