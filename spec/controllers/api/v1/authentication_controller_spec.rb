# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::AuthenticationController do
  include Helpers::JsonHelpers

  describe 'POST #sign_up' do
    context 'with valid parameters' do
      it 'creates a new user and signs in' do
        post :sign_up, params: { email: 'test@example.com', password: 'Password12@' }
        expect(response).to have_http_status(:ok)
        expect(json_body).to have_key(:token)
        expect(json_body).to have_key(:expires_at)
      end
    end
  end

  describe 'POST #sign_in' do
    let(:user) { create(:user, email: 'test@example.com', password: 'Password12@') }

    context 'with valid credentials' do
      it 'signs in and returns a token' do
        post :sign_in, params: { email: user.email, password: 'Password12@' }
        expect(response).to have_http_status(:ok)
        expect(json_body).to have_key(:token)
        expect(json_body).to have_key(:expires_at)
      end
    end

    context 'with invalid credentials' do
      it 'returns unprocessable entity status' do
        post :sign_in, params: { email: user.email, password: 'Wrong_password12@' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
