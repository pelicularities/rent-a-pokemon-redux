class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]

  def index
    @pokemon = Pokemon.all
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
      redirect_to pokemon_path(pokemon)
    else
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
