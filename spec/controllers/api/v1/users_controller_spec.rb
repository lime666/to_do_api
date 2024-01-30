# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::UsersController do
  include Helpers::JsonHelpers
  let!(:user) { create :user }
  let!(:token) { JsonWebToken.encode(user_id: user.id) }

  describe 'GET api/v1/user/me' do
    context 'user not authorize' do
      before do
        get :me
      end

      it { expect(response).to have_http_status :unauthorized }
    end

    context 'user authorize' do
      before do
        sign_in_as(user, 'Authorization', token)
        get :me
      end

      it { expect(response).to have_http_status :ok }
    end
  end

  describe 'PATCH api/v1/user/update_my_account' do
    let(:password) { '123456Aa@' }
    let(:password_confirmation) { '123456Aa@' }

    before do
      sign_in_as(user, 'Authorization', token)
    end

    context 'password != password_confirmation' do
      let!(:params) do
        { password:,
          password_confirmation: 'string123' }
      end

      it 'return error' do
        patch(:update_my_account, params:)

        expect(response).to have_http_status :bad_request
      end
    end

    context 'password == password_confirmation' do
      let!(:params) do
        { password:,
          password_confirmation: }
      end

      it 'updates the password' do
        patch(:update_my_account, params:)

        expect(response).to have_http_status :ok
      end
    end

    context 'with invalid params' do
      let!(:params) { { user: { email: 'some_invalid_email' } } }

      it 'return error' do
        patch(:update_my_account, params:)

        expect(response).to have_http_status :bad_request
      end
    end
  end

  describe 'DELETE api/v1/user/destroy_my_account' do
    context 'user authorize' do
      before do
        sign_in_as(user, 'Authorization', token)
        delete :destroy_my_account
      end

      it { expect(response).to have_http_status :no_content }
    end
  end
end
