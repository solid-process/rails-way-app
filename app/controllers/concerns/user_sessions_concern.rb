# frozen_string_literal: true

module UserSessionsConcern
  extend ActiveSupport::Concern

  def new_session
    @user = User.new
  end

  def create_session
    @user = User.authenticate_by(user_session_params)

    respond_to do |format|
      if @user
        format.html do
          sign_in(@user)

          redirect_to task_list_task_items_path(Current.task_list_id), notice: "You have successfully signed in!"
        end
        format.json { render "shared/users/user_token", status: :ok }
      else
        format.html do
          flash.now[:alert] = "Invalid email or password. Please try again."

          @user = User.new(email: user_session_params[:email])

          render :new_session, status: :unprocessable_entity
        end
        format.json do
          render("errors/unauthorized", status: :unauthorized, locals: {
            message: "Invalid email or password. Please try again."
          })
        end
      end
    end
  end

  def destroy_session
    sign_out

    redirect_to new_session_users_path, notice: "You have successfully signed out."
  end

  private

  def user_session_params
    params.require(:user).permit(:email, :password)
  end
end
