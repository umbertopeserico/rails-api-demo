class Api::V1::Flights::Reservations::ReservationsController < Api::V1::BaseController

  before_action :authenticate_passenger

  def create
    @reservation = current_passenger.reservations.new(reservation_params)

    if @reservation.save
      render json: {
          data: @reservation,
          status: '201'
      }, status: 201
    else
      render json: {
          data: @reservation,
          errors: @reservation.errors,
          status: '422'
      }, status: 422
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:execution_id)
  end

end
