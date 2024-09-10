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

  include UserRegistrationsConcern
  include UserSessionsConcern
  include UserPasswordsConcern
  include UserTokensConcern
  include UserProfilesConcern
end
