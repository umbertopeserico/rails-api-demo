class Api::V1::BaseController < ActionController::API
  include Api::V1::Auth::Passengers::SessionsHelper
end
