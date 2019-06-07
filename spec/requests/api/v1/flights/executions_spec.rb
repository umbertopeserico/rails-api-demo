require 'rails_helper'

RSpec.describe 'Api::V1::Flights::Executions', type: :request do
  describe 'GET /api/flights/search' do
    before do
      FactoryBot.create(:v1_flights_execution)
      FactoryBot.create(:v1_flights_execution)
      FactoryBot.create(:v1_flights_execution)

      @executions = V1::Flights::Execution.all
    end

    it 'should return all executions' do
      get api_v1_flights_search_path
      expect(response).to have_http_status(200)

      expect(JSON.parse(response.body)).to be == JSON.parse({data: @executions}.to_json)
    end

    describe 'with matching from parameter' do
      it 'should return executions with from parameter' do
        result = V1::Flights::Execution.search(from: V1::Flights::Airport.first.id)

        get api_v1_flights_search_path, params: {from: V1::Flights::Airport.first.id}
        expect(response).to have_http_status(200)

        expect(JSON.parse(response.body)).to be == JSON.parse({data: result}.to_json)
      end
    end

    describe 'with not matching from parameter' do
      it 'should return executions with from parameter' do
        result = V1::Flights::Execution.search(from: 'invalid')

        get api_v1_flights_search_path, params: {from: 'invalid'}
        expect(response).to have_http_status(200)

        expect(JSON.parse(response.body)).to be == JSON.parse({data: result}.to_json)
      end
    end

    describe 'with matching to parameter' do
      it 'should return executions with from parameter' do
        result = V1::Flights::Execution.search(to: V1::Flights::Airport.first.id)

        get api_v1_flights_search_path, params: {to: V1::Flights::Airport.first.id}
        expect(response).to have_http_status(200)

        expect(JSON.parse(response.body)).to be == JSON.parse({data: result}.to_json)
      end
    end

    describe 'with not matching to parameter' do
      it 'should return executions with to parameter' do
        result = V1::Flights::Execution.search(to: 'invalid')

        get api_v1_flights_search_path, params: {to: 'invalid'}
        expect(response).to have_http_status(200)

        expect(JSON.parse(response.body)).to be == JSON.parse({data: result}.to_json)
      end
    end
  end
end
