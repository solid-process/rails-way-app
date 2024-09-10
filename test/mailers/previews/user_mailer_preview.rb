# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def reset_password
    UserMailer.with(user: sample_user, token: "token").reset_password
  end

  def email_confirmation
    UserMailer.with(user: sample_user, token: "token").email_confirmation
  end

  private

  def sample_user = User.new(email: "email@example.com")
end
