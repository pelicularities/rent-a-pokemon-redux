class Pokedex < ApplicationRecord
  has_many :pokemons
  validates :species, presence: true, uniqueness: true

  def to_label
    self.species
  end
  
end
