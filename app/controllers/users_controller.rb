# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_guest_access!, except: %i[
    destroy destroy_session
    edit_token update_token
    edit_profile update_profile
  ]
  before_action :authenticate_user!, only: %i[
    destroy destroy_session
    edit_token update_token
    edit_profile update_profile
  ]
  before_action :set_user_by_token, only: %i[edit_password update_password]

  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.new(user_registration_params)

    respond_to do |format|
      if @user.save
        format.html do
          sign_in(@user)

          redirect_to task_list_task_items_path(Current.task_list_id), notice: "You have successfully registered!"
        end
        format.json { render "shared/users/user_token", status: :created }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render("errors/from_model", status: :unprocessable_entity, locals: { model: @user }) }
      end
    end
  end

  def destroy
    Current.user.destroy!

    respond_to do |format|
      format.html do
        sign_out

        redirect_to root_path, notice: "Your account has been deleted."
      end
      format.json { head :no_content }
    end
  end

  def new_session
    @user = User.new
  end

  def create_session
    @user = User.authenticate_by(user_session_params)

    respond_to do |format|
      if @user
        format.html do
          sign_in(@user)

          redirect_to task_list_task_items_path(Current.task_list_id), notice: "You have successfully signed in!"
        end
        format.json { render "shared/users/user_token", status: :ok }
      else
        format.html do
          flash.now[:alert] = "Invalid email or password. Please try again."

          @user = User.new(email: user_session_params[:email])

          render :new_session, status: :unprocessable_entity
        end
        format.json do
          render("errors/unauthorized", status: :unauthorized, locals: {
            message: "Invalid email or password. Please try again."
          })
        end
      end
    end
  end

  def destroy_session
    sign_out

    redirect_to new_session_users_path, notice: "You have successfully signed out."
  end

  def new_password
    @user = User.new
  end

  def create_password
    user = User.find_by(email: params.require(:user).require(:email))

    if user
      UserMailer.with(
        user: user,
        token: user.generate_token_for(:reset_password)
      ).reset_password.deliver_later
    end

    respond_to do |format|
      format.html { redirect_to new_session_users_path, notice: "Check your email to reset your password." }
      format.json { render(status: :ok, json: { status: :success }) }
    end
  end

  def edit_password
  end

  def update_password
    respond_to do |format|
      if @user.update(user_password_params)
        format.html do
          redirect_to new_session_users_path, notice: "Your password has been reset successfully. Please sign in."
        end
        format.json { render(status: :ok, json: { status: :success }) }
      else
        format.html { render :edit_password, status: :unprocessable_entity }
        format.json { render("errors/from_model", status: :unprocessable_entity, locals: { model: @user }) }
      end
    end
  end

  def edit_token
  end

  def update_token
    Current.user.user_token.refresh!

    respond_to do |format|
      format.html do
        cookies.encrypted[:user_token] = { value: Current.user.user_token.value, expires: 30.seconds.from_now }

        redirect_to(edit_token_users_path, notice: "API token updated.")
      end
      format.json do
        @user = Current.user

        render "shared/users/user_token", status: :ok
      end
    end
  end

  def edit_profile
  end

  def update_profile
    user_profile_params[:password_challenge] = user_profile_params.delete(:current_password) if user_profile_params.key?(:current_password)

    respond_to do |format|
      if Current.user.update(user_profile_params)
        format.html { redirect_to edit_profile_users_path, notice: "Your password has been updated." }
        format.json { render(status: :ok, json: { status: :success }) }
      else
        format.html { render(:edit_profile, status: :unprocessable_entity) }
        format.json do
          message = Current.user.errors.full_messages.join(", ")
          message.gsub!("Password challenge", "Current password")

          details = Current.user.errors.to_hash
          details[:current_password] = details.delete(:password_challenge) if details[:password_challenge]

          render_json_with_error(status: :unprocessable_entity, message:, details:)
        end
      end
    end
  end

  private

  def user_registration_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_session_params
    params.require(:user).permit(:email, :password)
  end

  def set_user_by_token
    @user = User.find_by_token_for(:reset_password, params[:id]) || User.find_by(id: params[:id])

    return if @user

    respond_to do |format|
      format.html { redirect_to new_password_users_path, alert: "Invalid or expired token." }
      format.json { render("errors/response", status: :unprocessable_entity, locals: { message: "Invalid token" }) }
    end
  end

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_profile_params
    @user_profile_params ||= params.require(:user).permit(
      :current_password,
      :password,
      :password_confirmation,
      :password_challenge
    ).with_defaults(password_challenge: "")
  end
end
