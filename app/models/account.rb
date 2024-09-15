# frozen_string_literal: true

class Account < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :task_lists, dependent: :destroy, class_name: "Task::List"
  has_many :members, through: :memberships

  has_one :ownership, -> { owner }, class_name: "Membership", inverse_of: :account, dependent: nil
  has_one :inbox, -> { inbox }, class_name: "Task::List", inverse_of: :account, dependent: nil
  has_one :owner, through: :ownership, source: :member

  validates :uuid, presence: true, format: UUID::REGEXP
end
