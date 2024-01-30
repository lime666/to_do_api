# frozen_string_literal: true

class Api::V1::ApplicationController < ApplicationController
  include JsonRenderable

  protect_from_forgery with: :null_session

  before_action :authorize_request

  attr_reader :current_user

  helper_method :current_user

  def authorize_request
    header = request.headers['Authorization']
    header = header.split.last if header.present?
    decoded = JsonWebToken.decode(header)
    @current_user ||= User.find(decoded[:user_id])
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
    error_response(e.message, :unauthorized)
  end
end
