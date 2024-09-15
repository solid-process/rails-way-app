# frozen_string_literal: true

class Account::Owner::Deletion
  attr_accessor :member

  def initialize(uuid: nil)
    self.member = Account::Member.find_by!(uuid:)
  end

  def process
    member.transaction do
      member.account.destroy
      member.destroy!
    end
  end
end
