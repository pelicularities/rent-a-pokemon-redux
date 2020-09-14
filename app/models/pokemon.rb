class Pokemon < ApplicationRecord
  belongs_to :user
  belongs_to :pokedex
  has_many :rentals
  validates :name, :description, :price, :location, presence: true
end
