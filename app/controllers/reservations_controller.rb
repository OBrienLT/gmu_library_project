class ReservationsController < ApplicationController

	# GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.order(:name).page(params[:page])
  end
end
