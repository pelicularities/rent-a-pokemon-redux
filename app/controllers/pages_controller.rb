class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def history
    user = current_user
    @rentals = user.rentals.all
  end
end
