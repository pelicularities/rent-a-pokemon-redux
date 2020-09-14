class Review < ApplicationRecord
  belongs_to :rental
  validates :description, :rating, presence: true
  validates :rating, numericality: { greater_than: -1, less_than: 6 }
end
