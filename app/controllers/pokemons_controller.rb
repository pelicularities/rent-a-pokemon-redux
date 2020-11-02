require 'date'

class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]

  def index
    # @pokemon = Pokemon.all
    if params[:query].present?
      # @pokemon = Pokemon.where("name ILIKE ?", "%#{params[:query]}%")
      sql_query = " \
        pokemons.name ILIKE :query \
        OR pokemons.description ILIKE :query \
        OR pokedexes.species ILIKE :query \
        OR users.username ILIKE :query \
      "
      @pokemon = Pokemon.joins(:pokedex, :user).where(sql_query, query: "%#{params[:query]}%")
    else
      @pokemon = Pokemon.all
    end

  end


def show

end

def new
  @pokemon = Pokemon.new
end

def create
  pokemon = Pokemon.new(pokemon_params)
  pokemon.user = current_user
  if pokemon.save
    redirect_to pokemons_path
  else
    @pokemon = Pokemon.new
    render :new
  end
end

def edit
end

def update
  @pokemon.update(pokemon_params)
  if @pokemon.save
    redirect_to pokemon_path(@pokemon)
  else
    render :edit
  end
end

def destroy
  @pokemon.destroy

  redirect_to pokemons_path
end

private

def set_pokemon
  @pokemon = Pokemon.find(params[:id])
end

def pokemon_params
  params.require(:pokemon).permit(:name, :description, :price, :location, :pokedex_id)
end
end
