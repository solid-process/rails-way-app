# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :member

  delegate :user,
           :user?,
           :task_list,
           :task_lists,
           :task_list_id,
           :task_items, to: :member, allow_nil: true

  def member!(**options)
    reset

    self.member = Account::Member.authorize(options)
  end

  def member?
    member.authorized?
  end
end
