# frozen_string_literal: true

class Account::Owner::Creation
  attr_accessor :member

  def initialize(uuid: nil)
    self.member = Account::Member.new(uuid:)
  end

  def process
    return { member: } if member.invalid?

    member.transaction do
      member.save!

      account = Account.create!(uuid: UUID.generate)

      account.memberships.create!(member:, role: :owner)

      account.task_lists.inbox.create!
    end

    { member: }
  end
end
