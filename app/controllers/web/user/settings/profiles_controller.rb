# frozen_string_literal: true

class Web::User::Settings::ProfilesController < Web::BaseController
  before_action :authenticate_user!

  def edit
  end

  def update
    if Current.user.update(user_params)
      redirect_to edit_user_settings_profile_path, notice: "Your password has been updated."
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :password,
      :password_confirmation,
      :password_challenge
    ).with_defaults(password_challenge: "")
  end
end
