# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::ProjectsController do
  include Helpers::JsonHelpers
  let!(:user) { create :user }
  let!(:token) { JsonWebToken.encode(user_id: user.id) }

  before do
    sign_in_as(user, 'Authorization', token)
  end

  describe 'GET api/v1/projects' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST api/v1/projects' do
    before do
      post :create, params:
    end

    let!(:params) { { title: 'Title', description: 'Description text' } }

    it { expect(response).to have_http_status :created }
    it { expect(Project.count).to eq 1 }
  end

  describe 'GET api/v1/projects/:id' do
    let!(:project) { create :project, user: }
    it 'returns a successful response' do
      get :show, params: { id: project.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH api/v1/projects/:id' do
    let!(:new_project) { create :project, user:, title: 'New title' }
    let!(:valid_params) { { new_project: { title: 'Updated' }, id: new_project.id } }

    it 'updates project' do
      patch :update, params: valid_params
      new_project.reload

      expect(response).to be_successful
    end
  end

  describe 'DELETE api/v1/projects/:id' do
    let!(:project_to_delete) { create :project, user: }

    it 'destroys the project' do
      expect do
        delete :destroy, params: { id: project_to_delete.id }
      end.to change(Project, :count).by(-1)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: project_to_delete.id }
      expect(response).to be_successful
    end
  end
end
