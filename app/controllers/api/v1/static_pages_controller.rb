class Api::V1::StaticPagesController < Api::V1::BaseController

  before_action :authenticate_passenger

  def index
    render json: {message: 'Hello World', user: current_passenger}
  end

end
