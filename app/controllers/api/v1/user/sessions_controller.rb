# frozen_string_literal: true

class API::V1::User::SessionsController < API::V1::BaseController
  def create
    @user = User.authenticate_by(user_params)

    if @user
      render "api/v1/user/token", status: :ok
    else
      render("api/v1/errors/unauthorized", status: :unauthorized, locals: {
        message: "Invalid email or password. Please try again."
      })
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
