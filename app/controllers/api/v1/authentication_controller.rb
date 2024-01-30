# frozen_string_literal: true

class Api::V1::AuthenticationController < Api::V1::ApplicationController
  skip_before_action :authorize_request

  def sign_up
    user = User.create!(email: params[:email], password: params[:password])

    if user
      sign_in
    else
      error_response(result.errors.full_messages, :unprocessable_entity)
    end
  end

  def sign_in
    user = User.find_by(email: params[:email])
    authenticated_user = user&.authenticate(params[:password])

    if authenticated_user
      token = JsonWebToken.encode(user_id: user.id)
      time = 3.months.from_now

      render json: { token:, expires_at: time }, status: :ok
    else
      error_response(t('errors.incorrect_credentials'), :unprocessable_entity)
    end
  end
end
