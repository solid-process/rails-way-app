# frozen_string_literal: true

class API::V1::User::TokensController < API::V1::BaseController
  before_action :authenticate_user!

  def update
    Current.user.token.refresh!

    @user = Current.user

    render "api/v1/user/token", status: :ok
  end
end
