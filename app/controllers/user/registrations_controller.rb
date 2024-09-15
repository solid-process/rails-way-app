# frozen_string_literal: true

class User::RegistrationsController < ApplicationController
  before_action :authenticate_user!, only: %i[destroy]
  before_action :require_guest_access!, except: %i[destroy]

  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html do
          sign_in(@user)

          redirect_to task_list_items_path(Current.task_list_id), notice: "You have successfully registered!"
        end
        format.json { render "user/shared/user_token", status: :created }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render("errors/from_model", status: :unprocessable_entity, locals: { model: @user }) }
      end
    end
  end

  def destroy
    Current.user.destroy!

    respond_to do |format|
      format.html do
        sign_out

        redirect_to root_path, notice: "Your account has been deleted."
      end
      format.json { head :no_content }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
