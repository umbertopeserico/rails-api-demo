class Api::V1::Auth::Passengers::SessionsController < Api::V1::BaseController

  def create
    user = ::V1::Passengers::Passenger.authenticate_by_email passenger_params
    if user
      render json: {
          data: {
              token: JsonWebToken.encode(user.jwt_payload)
          }
      }, status: 201
    else
      render json: {error: 'Invalid email or password', status: '422'}, status: 422
    end
  end

  private

  def passenger_params
    params.require(:passenger).permit(:email, :password)
  end

end
