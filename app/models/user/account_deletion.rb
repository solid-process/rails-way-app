# frozen_string_literal: true

class User::AccountDeletion
  include ActiveSupport::Configurable

  config_accessor :account_deletion, instance_writer: false,
                                     default: Account::Owner::Deletion

  attr_accessor :user

  def initialize(user: Current.user)
    self.user = user
  end

  def process
    user.transaction do
      account_deletion.new(uuid: user.uuid).process

      user.destroy!
    end
  end
end
