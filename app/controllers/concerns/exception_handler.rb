# frozen_string_literal: true
# 例外対応
module ExceptionHandler
  extend ActiveSupport::Concern
  included do
    rescue_from StandardError do |e|
      Rails.logger.fatal e.full_message
      json_response({ errors: [{ description: e.message, status: 500 }] }, :internal_server_error)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ errors: [{ description: e.message, status: 404 }] }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ errors: [{ description: e.message, status: 422 }] }, :unprocessable_entity)
    end

    rescue_from CanCan::AccessDenied do |e|
      message = "Not authorized to #{e.action} #{e.subject.is_a?(Class) ? e.subject.name : e.subject.class.name}"
      message += ":#{e.subject.id}" if e.subject.respond_to?(:id)

      render json: { errors: [{ description: message, status: 403 }] }, status: :forbidden
    end

    rescue_from ActionController::ParameterMissing do |e|
      json_response({ errors: [{ description: e.message, status: 422 }] }, :unprocessable_entity)
    end

    rescue_from JWT::DecodeError do
      json_response({ errors: [{ description: 'Unauthorized', status: 401 }] }, :unauthorized)
    end

    def json_response(obj, status = :ok)
      render json: obj, status: status
    end
  end
end
