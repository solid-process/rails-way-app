# frozen_string_literal: true

class Task::List < ApplicationRecord
  self.table_name = "task_lists"

  belongs_to :account

  has_many :items, dependent: :destroy, foreign_key: "task_list_id"

  scope :inbox, -> { where(inbox: true) }

  validates :name, presence: true

  before_validation :set_inbox_name, if: :inbox?

  normalizes(:name, with: -> { _1.strip })
  normalizes(:description, with: -> { _1.strip })

  def normal?
    !inbox?
  end

  private

  def set_inbox_name
    self.name = "Inbox"
    self.description = "This is your default list, it cannot be deleted."
  end
end
