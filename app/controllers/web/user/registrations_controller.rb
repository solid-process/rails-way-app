# frozen_string_literal: true

class Web::User::RegistrationsController < Web::BaseController
  before_action :authenticate_user!, only: %i[destroy]
  before_action :require_guest_access!, except: %i[destroy]

  def new
    @user = User.new

    render :new
  end

  def create
    @user = User::Registration.new(user_params).process.fetch(:user)

    if @user.errors.empty?
      sign_in(@user)

      redirect_to task_list_items_path(Current.task_list_id), notice: "You have successfully registered!"
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def destroy
    User::AccountDeletion.new.process

    sign_out

    redirect_to root_path, notice: "Your account has been deleted."
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
