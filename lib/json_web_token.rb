# frozen_string_literal: true

require 'jwt'

class JsonWebToken
  @rsa_private = OpenSSL::PKey::RSA.generate 2048
  @rsa_public = @rsa_private.public_key

  def self.encode(payload, exp = 3.months.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, @rsa_private, 'RS256')
  end

  def self.decode(token)
    decoded = JWT.decode(token, @rsa_public, true, { algorithm: 'RS256' })[0]
    HashWithIndifferentAccess.new(decoded)
  end
end
