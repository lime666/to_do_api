# frozen_string_literal: true

require 'swagger_helper'

describe 'Users' do
  path '/api/v1/user/me' do
    get('show user') do
      security [bearerAuth: []]
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'Show user') do
        schema '$ref': '#/definitions/user'
        run_test!
      end

      response(404, 'user not found') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end
  end

  path '/api/v1/user/update_my_account' do
    patch('update user') do
      security [bearerAuth: []]
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        '$ref': '#/definitions/user_params'
      }

      response(200, 'user updated') do
        schema '$ref': '#/definitions/user'
        run_test!
      end

      response(400, 'Not correct parameters.') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end
  end

  path '/api/v1/user/destroy_my_account' do
    delete('delete user') do
      security [bearerAuth: []]
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'

      response(204, 'user successfully destroyed') do
        run_test!
      end

      response(404, 'user not found') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end
  end
end
