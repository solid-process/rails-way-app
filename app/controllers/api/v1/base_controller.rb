# frozen_string_literal: true

class API::V1::BaseController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  rescue_from ActionController::ParameterMissing do |exception|
    render_json_with_error(status: :bad_request, message: exception.message)
  end

  private

  def authenticate_user!
    current_member!

    return if Current.user?

    render("api/v1/errors/unauthorized", status: :unauthorized)
  end

  def current_member!
    authenticate_with_http_token do |user_token|
      task_list_id = controller_name == "task_lists" ? params[:id] : params[:list_id]

      Current.member!(user_token:, task_list_id:)
    end
  end

  def render_json_with_model_errors(record)
    message = record.errors.full_messages.join(", ")
    details = record.errors.messages

    render_json_with_error(status: :unprocessable_entity, message:, details:)
  end

  def render_json_with_error(status:, message:, details: {})
    render(status:, json: { status: :error, message:, details: })
  end
end
