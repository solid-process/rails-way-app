# frozen_string_literal: true

class Web::User::PasswordsController < Web::BaseController
  before_action :require_guest_access!
  before_action :set_user_by_token, only: %i[edit update]

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params.require(:user).require(:email))

    if user
      UserMailer.with(
        user: user,
        token: user.generate_token_for(:reset_password)
      ).reset_password.deliver_later
    end

    redirect_to new_user_session_path, notice: "Check your email to reset your password."
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to new_user_session_path, notice: "Your password has been reset successfully. Please sign in."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user_by_token
    @user = User.find_by_token_for(:reset_password, params[:id])

    return if @user

    redirect_to new_user_password_path, alert: "Invalid or expired token."
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
