class RentalsController < ApplicationController
  before_action :set_pokemon, only: [:new, :create]

  def new
    @rental = Rental.new
  end

  def create
    rental = Rental.new(rental_params)
    rental.user = current_user
    rental.pokemon = @pokemon
    rental.price = @pokemon.price
    if rental.save
      redirect_to pokemon_path(@pokemon)
    else
      redirect_to pokemons_path
    end
  end
  
  private
  def set_pokemon
    @pokemon = Pokemon.find(params[:pokemon_id])
  end

  def rental_params
    params.require(:rental).permit([:start_date, :end_date])
  end
end
