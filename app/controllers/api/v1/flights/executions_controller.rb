class Api::V1::Flights::ExecutionsController < Api::V1::BaseController

  def search
    @executions = ::V1::Flights::Execution.search(search_params)

    render json: {
        data: @executions
    }
  end

  private

  def search_params
    params.permit(:from, :to)
  end

end
