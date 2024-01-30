# frozen_string_literal: true

module JsonRenderable
  def error_response(message, status)
    render json: { error: message }, status:
  end

  def not_found
    error_response(t('errors.not_found'), :not_found)
  end

  def success_response(message, status)
    render json: { data: message }, status:
  end
end
