# frozen_string_literal: true

module UserProfilesConcern
  extend ActiveSupport::Concern

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

  def user_profile_params
    @user_profile_params ||= params.require(:user).permit(
      :current_password,
      :password,
      :password_confirmation,
      :password_challenge
    ).with_defaults(password_challenge: "")
  end
end
