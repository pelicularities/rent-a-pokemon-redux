require 'date'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @pokemon = Pokemon.all
  end

  def history
    user = current_user
    @rentals = {
      upcoming: {
        from: user.rentals.where("start_date > ?", Time.now.to_date),
        to: []
      },
      present: {
        from: user.rentals.where("start_date <= ?", Time.now.to_date).where("end_date >= ?", Time.now.to_date),
        to: []
      },
      past: {
        from: user.rentals.where("end_date < ?", Time.now.to_date),
        to: []
      }
    }
    # @rentals = user.rentals.all

  end
end
