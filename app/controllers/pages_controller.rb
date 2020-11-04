require 'date'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @pokemon = Pokemon.where.not(user: current_user).order(created_at: :desc).limit(3)
  end

  def history
    user = current_user
    @rentals = {
      upcoming: {
        from: user.rentals.where("start_date > ?", Time.now.to_date).order(start_date: :asc),
        to: Rental.joins(pokemon: :user).where(pokemons: { user: user }).where("start_date > ?", Time.now.to_date).order(start_date: :asc)
      },
      present: {
        from: user.rentals.where("start_date <= ?", Time.now.to_date).where("end_date >= ?", Time.now.to_date).order(start_date: :asc),
        to: Rental.joins(pokemon: :user).where(pokemons: { user: user }).where("start_date <= ?", Time.now.to_date).where("end_date >= ?", Time.now.to_date).order(start_date: :asc)
      },
      past: {
        from: user.rentals.where("end_date < ?", Time.now.to_date).order(end_date: :desc),
        to: Rental.joins(pokemon: :user).where(pokemons: { user: user }).where("end_date < ?", Time.now.to_date).order(end_date: :desc)
      }
    }
    # @rentals = user.rentals.all
  end

  def my_pokemon
    @pokemon = Pokemon.where(user: current_user);
  end
end
