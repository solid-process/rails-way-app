# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  prepend_before_action do
    request.format = :json if Mime[:json].match?(request.headers["CONTENT_TYPE"])
  end

  skip_forgery_protection if: -> { request.format.json? }

  rescue_from ActionController::ParameterMissing do |exception|
    raise exception unless request.format.json?

    render_json_with_error(status: :bad_request, message: exception.message)
  end

  private

  def authenticate_user!
    current_member!

    return if Current.user?

    respond_to do |format|
      format.html do
        alert, next_path =
          if current_user_id.present?
            [ "The page you are looking for does not exist, or you cannot access it.", task_lists_path ]
          else
            [ "You need to sign in or sign up before continuing.", new_session_users_path ]
          end

        redirect_to next_path, alert:
      end
      format.json { render("errors/unauthorized", status: :unauthorized) }
    end
  end

  def require_guest_access!
    current_member!

    return unless Current.user?

    respond_to do |format|
      format.html do
        redirect_to task_lists_path, notice: "You are already signed in."
      end
    end
  end

  def current_member!
    if request.format.json?
      authenticate_with_http_token do |user_token|
        Current.member!(user_token:, task_list_id: params[:task_list_id])
      end
    else
      task_list_id = params[:task_list_id]
      task_list_id = current_task_list_id if task_list_id.blank?

      Current.member!(user_id: current_user_id, task_list_id:)

      self.current_task_list_id = Current.task_list_id if Current.member?
    end
  end

  def current_user_id=(id)
    session[:user_id] = id
  end

  def current_user_id
    session[:user_id]
  end

  def current_task_list_id=(id)
    session[:task_list_id] = id
  end

  def current_task_list_id
    session[:task_list_id]
  end

  def sign_in(user)
    sign_out

    self.current_user_id = user.id

    current_member!
  end

  def sign_out
    Current.reset

    reset_session
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
