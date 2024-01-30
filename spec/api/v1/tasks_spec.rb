# frozen_string_literal: true

require 'swagger_helper'

describe 'Tasks' do
  path '/api/v1/tasks' do
    post('Create task') do
      security [bearerAuth: []]
      tags 'Tasks'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :task, in: :body, schema: {
        '$ref': '#/definitions/task_params'
      }

      response(201, 'task created') do
        schema '$ref': '#/definitions/task'
        run_test!
      end

      response(422, 'Error message') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end

    get('Show all the tasks') do
      security [bearerAuth: []]
      tags 'Tasks'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :status, in: :query, type: :string, description: 'Task status for filtering. Options: new_made, in_progress, done.'

      response(200, 'List of all tasks') do
        schema '$ref': '#/definitions/task'
        run_test!
      end

      response(422, 'Invalid credentials') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end
  end

  path '/api/v1/tasks/{id}' do
    parameter name: :id, in: :path, type: :integer, description: 'task id'

    get('show task') do
      security [bearerAuth: []]
      tags 'Tasks'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'Show task') do
        schema '$ref': '#/definitions/task_params'
        run_test!
      end

      response(404, 'task not found') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end

    patch('update task') do
      security [bearerAuth: []]
      tags 'Tasks'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :task, in: :body, schema: {
        '$ref': '#/definitions/task_params'
      }

      response(200, 'task updated') do
        schema '$ref': '#/definitions/task'
        run_test!
      end

      response(422, 'Not correct parameters.') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end

    delete('delete task') do
      security [bearerAuth: []]
      tags 'Tasks'
      consumes 'application/json'
      produces 'application/json'

      response(204, 'task successfully destroyed') do
        run_test!
      end

      response(404, 'task not found') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end
  end
end
