# frozen_string_literal: true

class Account::Member::Authorization
  attr_reader :member

  def initialize(member)
    @member = member
  end

  def authorize!
    return if member.invalid?

    find_user.then do |user|
      member.user = user
      member.user_id ||= user&.id
      member.account_id = user&.member_account_id
      member.task_list_id = user&.member_task_list_id
    end
  end

  private

  def find_user
    account_id = member.task_list_id ? "task_lists.account_id" : "memberships.account_id"

    users_relation.select("users.*, task_lists.id AS member_task_list_id, #{account_id} AS member_account_id").first
  end

  def users_relation
    return users_left_joins.where(users: { id: member.user_id }) if member.user_id?

    short, long = User::Token.parse_value(member.user_token)

    checksum = User::Token.checksum(short:, long:)

    users_left_joins.joins(:token).where(user_tokens: { short:, checksum: })
  end

  def users_left_joins
    task_list_assignment = member.task_list_id ? [ "id = ?", member.task_list_id ] : "inbox = TRUE"
    task_lists_condition = "task_lists.#{sanitize_sql_for_assignment(task_list_assignment)}"

    membership_assignment = sanitize_sql_for_assignment([ "account_id = ?", member.account_id ]) if member.account_id
    memberships_condition = "AND memberships.#{membership_assignment}" if membership_assignment

    User
      .joins("LEFT JOIN memberships ON users.id = memberships.user_id #{memberships_condition}")
      .joins("LEFT JOIN task_lists ON task_lists.account_id = memberships.account_id AND #{task_lists_condition}")
  end

  def sanitize_sql_for_assignment(...)
    ActiveRecord::Base.sanitize_sql_for_assignment(...)
  end
end
