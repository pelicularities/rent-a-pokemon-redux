class Pokemon < ApplicationRecord
  belongs_to :user
  belongs_to :pokedex
  has_many :rentals, dependent: :destroy
  validates :name, :description, :price, :location, presence: true

  def unavailable_dates
    rentals.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end
end
