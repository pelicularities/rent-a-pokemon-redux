class Pokedex < ApplicationRecord
  has_many :pokemons
  validates :species, presence: true, uniqueness: true
end
