require 'rails_helper'

RSpec.describe 'Api::V1::Flights::Reservations::Reservations', type: :request do
  before do
    @headers = {'Accept' => 'application/vnd.rails-api-demo.v1+json'}
  end

  context 'POST /api/flights/reservations' do
    describe 'without Authorization header' do
      it 'should return 401' do
        post api_v1_flights_reservations_reservations_path, {headers: @headers}

        expect(response).to have_http_status(401)
      end
    end

    describe 'with valid Authentication header' do
      before do
        passenger = FactoryBot.create(:v1_passengers_passenger)
        @token = JsonWebToken.encode(passenger.jwt_payload)
        @headers['Authorization'] =  "Bearer #{@token}"
      end

      describe 'with valid params' do
        before do
          @execution = FactoryBot.create(:v1_flights_execution)
        end

        it 'should return 201' do
          post api_v1_flights_reservations_reservations_path, {
              params: {reservation: {execution_id: @execution.id}},
              headers: @headers
          }

          expect(response).to have_http_status(201)
        end
      end

      describe 'with invalid params' do
        before do
          @execution = FactoryBot.create(:v1_flights_execution)
        end

        it 'should return 422' do
          post api_v1_flights_reservations_reservations_path, {
              params: {reservation: {execution_id: 'invalid'}},
              headers: @headers
          }

          expect(response).to have_http_status(422)
        end
      end
    end
  end
end
