# frozen_string_literal: true

class Web::BaseController < ApplicationController
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def authenticate_user!
    current_member!

    return if Current.user?

    alert, next_path =
      if current_user_id.present?
        [ "The page you are looking for does not exist, or you cannot access it.", task_lists_path ]
      else
        [ "You need to sign in or sign up before continuing.", new_user_session_path ]
      end

    redirect_to next_path, alert:
  end

  def require_guest_access!
    current_member!

    return unless Current.user?

    redirect_to task_lists_path, notice: "You are already signed in."
  end

  def current_member!
    task_list_id = params[:list_id]
    task_list_id = current_task_list_id if task_list_id.blank?

    Current.member!(user_id: current_user_id, task_list_id:)

    self.current_task_list_id = Current.task_list_id if Current.member?
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
end
