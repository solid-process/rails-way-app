# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default template_path: "mailers/user"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.email_confirmation.subject
  #
  def email_confirmation
    mail to: params[:user].email, subject: "Confirm your email"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password.subject
  #
  def reset_password
    mail to: params[:user].email, subject: "Reset your password"
  end
end
