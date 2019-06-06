require 'rails_helper'

RSpec.describe JsonWebToken do

  before do
    @secret_key = ENV['JWT_SECRET_KEY']
  end

  describe 'encode' do
    before do
      @payload = {data: 'Ciao'}
      @check_payload = {data: 'Ciao', exp: 10.minutes.from_now.to_i}
      @expected = JWT.encode(@check_payload, @secret_key)
    end

    it 'should generate valid token' do
      expect(JsonWebToken.encode(@payload)).to be == @expected
    end
  end

  describe 'decode' do
    before do
      @payload = {data: 'Ciao'}.stringify_keys
      @token = JsonWebToken.encode(@payload)
    end

    it 'should get the payload previously encrypted' do
      expect(JsonWebToken.decode(@token)).to be == @payload.deep_stringify_keys
    end
  end

end