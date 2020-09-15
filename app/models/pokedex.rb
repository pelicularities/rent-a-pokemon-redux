class Pokedex < ApplicationRecord
  has_many :pokemons, dependent: :destroy
  validates :species, presence: true, uniqueness: true
  has_one_attached :artwork, dependent: :destroy
end
