# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      basePath: '/v1',
      paths: {},
      definitions: {
        user: {
          type: :object,
          properties: {
            id: { type: :integer },
            email: { type: :string, example: 'john@email.com' },
            created_at: { type: :string },
            updated_at: { type: :string }
          }
        },
        user_params: {
          type: :object,
          properties: {
            id: { type: :integer },
            email: { type: :string, example: 'john@email.com' },
            password: { type: :string, example: '1234567b' },
            password_confirmation: { type: :string, example: '1234567b' }
          }
        },
        error: {
          type: :object,
          properties: {
            error: { type: :string, example: 'Record not found.' }
          }
        },
        project: {
          type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string, example: 'Project 1' },
            description: { type: :string, example: 'Short desc for project' },
            user_id: { type: :integer, example: 1 }
          }
        },
        project_params: {
          type: :object,
          properties: {
            title: { type: :string, example: 'Project 1' },
            description: { type: :string, example: 'Short desc for project' }
          }
        },
        project_with_tasks: {
          type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string, example: 'Project 1' },
            description: { type: :string, example: 'Short desc for project' },
            user_id: { type: :integer, example: 1 },
            tasks: { type: :array }
          }
        },
        task: {
          type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string, example: 'Task 1' },
            description: { type: :string, example: 'Short desc for task' },
            status: { type: :string, example: 'New' },
            project_id: { type: :integer, example: 1 }
          }
        },
        task_params: {
          type: :object,
          properties: {
            title: { type: :string, example: 'Task 1' },
            description: { type: :string, example: 'Short desc for task' },
            status: { type: :string, example: 'New' },
            project_id: { type: :integer, example: 1 }
          }
        },
        auth: {
          type: :object,
          properties: {
            message: { type: :string, example: 'User was successfully created' },
            token: { type: :string, example: 'eyJhbGciOiJSUzI1NiJ9.eyJ1c2VyX2lkIjoyOCwiZXhwIj' }
          }
        },
        registration: {
          type: :object,
          properties: {
            token: { type: :string, example: 'eyJhbGciOiJSUzI1NiJ9.eyJ1c2VyX2lkIjoyOCwiZXhwIj' }
          }
        }
      },
      components: {
        securitySchemes: {
          bearerAuth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: 'JWT'
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
