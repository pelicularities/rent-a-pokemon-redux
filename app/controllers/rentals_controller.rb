class RentalsController < ApplicationController
  before_action :set_pokemon, only: [:new, :create, :success]

  def new
    @rental = Rental.new
  end

  def create
    rental = Rental.new(rental_params)
    rental.user = current_user
    rental.pokemon = @pokemon

    # params[:rental][:start_date] is a String (flatpickr requires a string input)
    # #to_date converts the string to a Date, subtraction of Date by another Date returns a Rational
    # Rational is converted to an integer, and we add 1 to include the first day of rental
    days = (params[:rental][:end_date].to_date - params[:rental][:start_date].to_date).to_i + 1
    rental.price = @pokemon.price * days
    if rental.save
      redirect_to history_path
    else
      render :new
    end

    def success
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
