# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::ApplicationController
  def me
    render json: @current_user, serializer: UserSerializer
  end

  def update_my_account
    if @current_user.update(user_params)
      render json: @current_user, serializer: UserSerializer
    else
      error_response(@current_user.errors.full_messages.first, :bad_request)
    end
  end

  def destroy_my_account
    if @current_user.destroy
      success_response(t('success.user_destroyed'), :no_content)
    else
      error_response(@current_user.errors.full_messages.first, :unprocessable_entity)
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
