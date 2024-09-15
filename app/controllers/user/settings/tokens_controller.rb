# frozen_string_literal: true

class User::Settings::TokensController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    Current.user.token.refresh!

    respond_to do |format|
      format.html do
        cookies.encrypted[:user_token] = { value: Current.user.token.value, expires: 30.seconds.from_now }

        redirect_to(edit_user_settings_token_path, notice: "API token updated.")
      end
      format.json do
        @user = Current.user

        render "user/shared/user_token", status: :ok
      end
    end
  end
end
