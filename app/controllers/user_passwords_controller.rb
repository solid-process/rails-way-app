# frozen_string_literal: true

class UserPasswordsController < ApplicationController
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

    respond_to do |format|
      format.html { redirect_to new_user_session_path, notice: "Check your email to reset your password." }
      format.json { render(status: :ok, json: { status: :success }) }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html do
          redirect_to new_user_session_path, notice: "Your password has been reset successfully. Please sign in."
        end
        format.json { render(status: :ok, json: { status: :success }) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render("errors/from_model", status: :unprocessable_entity, locals: { model: @user }) }
      end
    end
  end

  private

  def set_user_by_token
    @user = User.find_by_token_for(:reset_password, params[:id]) || User.find_by(id: params[:id])

    return if @user

    respond_to do |format|
      format.html { redirect_to new_user_password_path, alert: "Invalid or expired token." }
      format.json { render("errors/response", status: :unprocessable_entity, locals: { message: "Invalid token" }) }
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
