# frozen_string_literal: true

class API::V1::User::PasswordsController < API::V1::BaseController
  before_action :authenticate_user!

  def update
    user_params[:password_challenge] = user_params.delete(:current_password)

    if Current.user.update(user_params)
      render(status: :ok, json: { status: :success })
    else
      errors = Current.user.errors

      message = errors.full_messages.join(", ")
      message.gsub!("Password challenge", "Current password")

      details = errors.to_hash
      details[:current_password] = details.delete(:password_challenge) if details[:password_challenge]

      render_json_with_error(status: :unprocessable_entity, message:, details:)
    end
  end

  private

  def user_params
    @user_params ||= params.require(:user).permit(
      :password,
      :password_confirmation,
      :current_password
    ).with_defaults(current_password: "")
  end
end
