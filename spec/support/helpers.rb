# frozen_string_literal: true

module Helpers
  module JsonHelpers
    def json_body
      JSON.parse(response.body, symbolize_names: true)
    end

    def response_object
      json_body[:data][:response_object]
    end

    def response_errors
      json_body[:data][:errors]
    end

    def sign_in_as(_user, header_key, header_value)
      request_headers = request.headers
      request_headers[header_key] = header_value
    end
  end
end
