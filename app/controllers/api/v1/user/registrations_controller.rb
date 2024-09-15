# frozen_string_literal: true

class API::V1::User::RegistrationsController < API::V1::BaseController
  before_action :authenticate_user!, only: %i[destroy]

  def create
    case User::Registration.new(user_params).process
    in { user: } if user.errors.empty?
      @user = user

      render "api/v1/user/token", status: :created
    in { user: }
      render("api/v1/errors/from_model", status: :unprocessable_entity, locals: { model: user })
    end
  end

  def destroy
    User::AccountDeletion.new.process

    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
