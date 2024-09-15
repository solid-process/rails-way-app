# frozen_string_literal: true

class User::PasswordResetting
  attr_accessor :user

  def initialize(email:)
    self.user = User.find_by(email:)
  end

  def send_instructions
    return unless user

    UserMailer.with(
      user:,
      token: user.generate_token_for(:reset_password)
    ).reset_password.deliver_later
  end
end
