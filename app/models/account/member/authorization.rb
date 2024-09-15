# frozen_string_literal: true

class Account::Member::Authorization
  attr_reader :entity

  def self.with(params)
    entity = Account::Member::Entity.new(params)

    entity.tap { new(_1).authorize! }
  end

  def initialize(entity)
    @entity = entity
  end

  def authorize!
    return if entity.invalid?

    members_relation.first.then do
      entity.record = _1
      entity.uuid ||= _1&.uuid
      entity.account_id = _1&.member_account_id
      entity.task_list_id = _1&.member_task_list_id
    end
  end

  private

  def members_relation
    member_account_id = entity.task_list_id? ? "task_lists.account_id" : "memberships.account_id"

    task_list_assignment = entity.task_list_id? ? [ "id = ?", entity.task_list_id ] : "inbox = TRUE"
    task_lists_condition = "task_lists.#{sanitize_sql_for_assignment(task_list_assignment)}"

    membership_assignment = sanitize_sql_for_assignment([ "account_id = ?", entity.account_id ]) if entity.account_id
    memberships_condition = "AND memberships.#{membership_assignment}" if membership_assignment

    Account::Member
      .select("account_members.*, task_lists.id AS member_task_list_id, #{member_account_id} AS member_account_id")
      .joins("LEFT JOIN memberships ON account_members.id = memberships.member_id #{memberships_condition}")
      .joins("LEFT JOIN task_lists ON task_lists.account_id = memberships.account_id AND #{task_lists_condition}")
      .where(account_members: { uuid: entity.uuid })
  end

  def sanitize_sql_for_assignment(...)
    ActiveRecord::Base.sanitize_sql_for_assignment(...)
  end
end
