# frozen_string_literal: true

class User::AccountDeletion
  attr_accessor :user

  def initialize(user: Current.user)
    self.user = user
  end

  def process
    user.transaction do
      user.account.destroy!

      user.destroy!
    end
  end
end
