require 'rails_helper'

RSpec.describe 'Api::V1::Auth::Passengers::Sessions', type: :request do
  before do
    @passenger = FactoryBot.create(:v1_passengers_passenger, password: 'Ciao1234', password_confirmation: 'Ciao1234')
    @attributes = @passenger.attributes
  end

  describe 'POST /api/auth/passengers/sessions' do

    describe 'with valid data' do
      before do
        @valid_token = JsonWebToken.encode(@passenger.jwt_payload)
      end

      it 'should return a JWT token' do
        post api_v1_auth_passengers_sessions_path, params: {
            passenger: {email: @passenger.email, password: 'Ciao1234'}
        }

        expect(response).to have_http_status(201)

        body = JSON.parse(response.body)

        expect(body['data']['token']).to be == @valid_token
      end
    end

    describe 'with invalid data' do
      before do
        @valid_token = JsonWebToken.encode(@passenger.jwt_payload)
      end

      it 'should return a JWT token' do
        post api_v1_auth_passengers_sessions_path, params: {
            passenger: {email: @passenger.email, password: 'Ciao12345'}
        }

        expect(response).to have_http_status(422)

        body = JSON.parse(response.body)

        expect(body.key?('errors')).not_to be
      end
    end

  end
end
