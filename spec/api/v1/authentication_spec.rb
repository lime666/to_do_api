# frozen_string_literal: true

require 'swagger_helper'

describe 'Authentication' do
  path '/api/v1/auth/sign_up' do
    post('Sign up authentication') do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :email, in: :query, type: :string, description: 'user email'
      parameter name: :password, in: :query, type: :string, description: 'user password'

      response(200, 'Valid credentials') do
        schema '$ref': '#/definitions/registration'
        run_test!
      end

      response(422, 'Invalid credentials') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end
  end

  path '/api/v1/auth/sign_in' do
    post('Sign in authentication') do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :email, in: :query, type: :string, description: 'user email'
      parameter name: :password, in: :query, type: :string, description: 'user password'

      response(200, 'Valid credentials') do
        schema '$ref': '#/definitions/auth'
        run_test!
      end

      response(422, 'Invalid credentials') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end
  end
end
