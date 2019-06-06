require 'jwt'

class JsonWebToken
  class << self

    def encode(payload, exp = 10.minutes.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, ENV.fetch('JWT_SECRET_KEY', Rails.application.secret_key_base))
    end

    def decode(token)
      body = JWT.decode(token, ENV.fetch('JWT_SECRET_KEY', Rails.application.secret_key_base))[0]
      HashWithIndifferentAccess.new body
    rescue
      nil
    end

  end
end