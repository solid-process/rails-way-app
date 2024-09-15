# frozen_string_literal: true

class API::V1::User::Passwords::ResettingsController < API::V1::BaseController
  before_action :set_user_by_token, only: %i[update]

  def create
    User.send_reset_password_instructions(email: params.require(:user).require(:email))

    render(status: :ok, json: { status: :success })
  end

  def update
    if @user.update(user_params)
      render(status: :ok, json: { status: :success })
    else
      render("api/v1/errors/from_model", status: :unprocessable_entity, locals: { model: @user })
    end
  end

  private

  def set_user_by_token
    @user = User.find_by_reset_password(token: params[:token])

    return if @user

    render("api/v1/errors/response", status: :unprocessable_entity, locals: { message: "Invalid token" })
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
