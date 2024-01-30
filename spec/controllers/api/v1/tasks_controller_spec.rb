# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::TasksController do
  include Helpers::JsonHelpers
  let!(:user) { create :user }
  let!(:token) { JsonWebToken.encode(user_id: user.id) }
  let!(:project) { create :project, user: }

  before do
    sign_in_as(user, 'Authorization', token)
  end

  describe 'GET api/v1/tasks' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST api/v1/tasks' do
    before do
      post :create, params:
    end

    context 'with valid params' do
      let!(:params) { { title: 'Title', description: 'Description text', project_id: project.id } }

      it { expect(response).to have_http_status :created }
      it { expect(Task.count).to eq 1 }
    end

    context 'with invalid params' do
      let!(:params) { { title: 'Title', description: 'Description text', project_id: nil } }

      it { expect(response).to have_http_status :bad_request }
      it { expect(Task.count).to eq 0 }
    end
  end

  describe 'GET api/v1/tasks/:id' do
    let!(:task) { create :task, project: }
    it 'returns a successful response' do
      get :show, params: { id: task.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH api/v1/tasks/:id' do
    let!(:new_task) { create :task, project:, title: 'New title' }

    context 'with valid params' do
      let!(:valid_params) { { new_task: { title: 'Updated' }, id: new_task.id } }

      it 'updates task' do
        patch :update, params: valid_params
        new_task.reload

        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE api/v1/tasks/:id' do
    let!(:task_to_delete) { create :task, project: }

    it 'destroys the task' do
      expect do
        delete :destroy, params: { id: task_to_delete.id }
      end.to change(Task, :count).by(-1)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: task_to_delete.id }
      expect(response).to be_successful
    end
  end
end
