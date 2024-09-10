# frozen_string_literal: true

module UserTokensConcern
  extend ActiveSupport::Concern

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

  private

  def set_user_by_token
    @user = User.find_by_token_for(:reset_password, params[:id]) || User.find_by(id: params[:id])

    return if @user

    respond_to do |format|
      format.html { redirect_to new_password_users_path, alert: "Invalid or expired token." }
      format.json { render("errors/response", status: :unprocessable_entity, locals: { message: "Invalid token" }) }
    end
  end
end
