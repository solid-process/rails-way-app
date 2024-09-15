# frozen_string_literal: true

class User::Registration
  attr_accessor :user

  def initialize(attributes = {})
    self.user = User.new(attributes)
  end

  def process
    create_user_and_account! if user.valid?

    { user: }
  end

  private

  def create_user_and_account!
    user.transaction do |transaction|
      user.save!

      user.create_token!

      create_account!

      transaction.after_commit { send_confirmation_email! }
    end
  end

  def create_account!
    account = Account.create!(uuid: SecureRandom.uuid)

    account.memberships.create!(user:, role: :owner)

    account.task_lists.inbox.create!
  end

  def send_confirmation_email!
    UserMailer.with(
      user:,
      token: user.generate_token_for(:email_confirmation)
    ).email_confirmation.deliver_later
  end
end
