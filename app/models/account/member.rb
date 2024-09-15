# frozen_string_literal: true

class Account
  class Member < ApplicationRecord
    self.table_name = "account_members"

    with_options foreign_key: :member_id, inverse_of: :member, class_name: "Membership" do
      has_many :memberships, dependent: :destroy

      has_one :ownership, -> { owner }, dependent: nil
    end

    has_many :accounts, through: :memberships
    has_many :task_lists, through: :accounts, class_name: "Task::List"

    has_one :account, through: :ownership
    has_one :inbox, through: :account, class_name: "Task::List"

    validates :uuid, presence: true, format: UUID::REGEXP
  end
end
