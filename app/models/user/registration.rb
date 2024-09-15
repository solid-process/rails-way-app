# frozen_string_literal: true

class User::Registration
  include ActiveSupport::Configurable

  with_options instance_writer: false do
    config_accessor :mailer, default: UserMailer
    config_accessor :account_creation, default: Account::Owner::Creation
  end

  attr_accessor :user

  def initialize(attributes = {})
    self.user = User.new(attributes)
  end

  def process
    user.uuid = UUID.generate

    create_user_and_account! if user.valid?

    { user: }
  end

  private

  def create_user_and_account!
    user.transaction do |transaction|
      user.save!

      user.create_token!

      account_creation.new(uuid: user.uuid).process

      transaction.after_commit { send_confirmation_email! }
    end
  end

  def send_confirmation_email!
    mailer.with(
      user:,
      token: user.generate_token_for(:email_confirmation)
    ).email_confirmation.deliver_later
  end
end
