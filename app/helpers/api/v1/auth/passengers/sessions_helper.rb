module Api::V1::Auth::Passengers::SessionsHelper

  def authenticate_passenger
    unless current_passenger
      render json: {errors: {not_authorized: 'Not authorized'}, status: '401'}, status: 401
    end
  end

  def current_passenger
    @current_passenger ||= ::V1::Passengers::Passenger.authenticate_by_token(authorization_token)
  end

  def authorization_token
    pattern = /^Bearer /
    header = request.headers['Authorization'] # <= env
    header.gsub(pattern, '') if header && header.match(pattern)
  end

end