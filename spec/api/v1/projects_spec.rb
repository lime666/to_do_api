# frozen_string_literal: true

require 'swagger_helper'

describe 'Projects' do
  path '/api/v1/projects' do
    post('Create project') do
      security [bearerAuth: []]
      tags 'Projects'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :title, in: :query, type: :string, description: 'project title'
      parameter name: :description, in: :query, type: :string, description: 'project description'

      response(201, 'Project created') do
        schema '$ref': '#/definitions/project'
        run_test!
      end

      response(422, 'Error message') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end

    get('Show all the projects') do
      security [bearerAuth: []]
      tags 'Projects'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'List of all projects') do
        schema '$ref': '#/definitions/project'
        run_test!
      end

      response(422, 'Invalid credentials') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end
  end

  path '/api/v1/projects/{id}' do
    parameter name: :id, in: :path, type: :integer, description: 'project id'

    get('show project') do
      security [bearerAuth: []]
      tags 'Projects'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'Show project') do
        schema '$ref': '#/definitions/project_params'
        run_test!
      end

      response(404, 'Project not found') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end

    patch('update project') do
      security [bearerAuth: []]
      tags 'Projects'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :project, in: :body, schema: {
        '$ref': '#/definitions/project_params'
      }

      response(200, 'Project updated') do
        schema '$ref': '#/definitions/project'
        run_test!
      end

      response(422, 'Not correct parameters.') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end

    delete('delete project') do
      security [bearerAuth: []]
      tags 'Projects'
      consumes 'application/json'
      produces 'application/json'

      response(204, 'Project successfully destroyed') do
        run_test!
      end

      response(404, 'project not found') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end
  end

  path '/api/v1/projects/index_projects_with_tasks' do
    get('Show all the projects with their tasks') do
      security [bearerAuth: []]
      tags 'Projects'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'List of all projects with tasks') do
        schema '$ref': '#/definitions/project_with_tasks'
        run_test!
      end

      response(422, 'Invalid credentials') do
        schema '$ref': '#/definitions/error'
        run_test!
      end
    end
  end
end
