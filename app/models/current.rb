# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :user, :task_list, :task_lists, :account
  attribute :user_id, :user_token, :account_id, :task_list_id

  def member!(**options)
    reset

    self.user = users_first(options)
    self.user_id ||= user&.id
    self.account_id = user&.member_account_id
    self.task_list_id = user&.member_task_list_id

    self.account = user&.accounts&.find_by(id: account_id)
    self.task_lists = account&.task_lists || TaskList.none
    self.task_list = task_lists.find_by(id: task_list_id)
  end

  def member? = user? && account_id? && task_list_id?

  def user_id? = user_id.present?

  def user_token? = user_token.present?

  def account_id? = account_id.present?

  def task_list_id? = task_list_id.present?

  def user? = user.present?

  def account? = account.present?

  def task_list? = task_list.present?

  def task_items
    task_list&.task_items || TaskItem.none
  end

  private

  def users_first(options)
    self.user_id = options[:user_id].presence
    self.user_token = options[:user_token].presence
    self.account_id = options[:account_id].presence
    self.task_list_id = options[:task_list_id].presence

    raise ArgumentError, "cannot be present when user_token is present" if user_id && user_token

    return unless user_id || user_token

    account_id = task_list_id ? "task_lists.account_id" : "memberships.account_id"

    users_relation.select("users.*, task_lists.id AS member_task_list_id, #{account_id} AS member_account_id").first
  end

  def users_relation
    return users_left_joins.where(users: { id: user_id }) if user_id

    short, long = UserToken.parse_value(user_token)

    checksum = UserToken.checksum(short:, long:)

    users_left_joins.joins(:user_token).where(user_tokens: { short:, checksum: })
  end

  def users_left_joins
    task_list_assignment = task_list_id ? [ "id = ?", task_list_id ] : "inbox = TRUE"
    task_lists_condition = "task_lists.#{sanitize_sql_for_assignment(task_list_assignment)}"

    membership_assignment = sanitize_sql_for_assignment([ "account_id = ?", account_id ]) if account_id
    memberships_condition = "AND memberships.#{membership_assignment}" if membership_assignment

    User
      .joins("LEFT JOIN memberships ON users.id = memberships.user_id #{memberships_condition}")
      .joins("LEFT JOIN task_lists ON task_lists.account_id = memberships.account_id AND #{task_lists_condition}")
  end

  def sanitize_sql_for_assignment(...)
    ActiveRecord::Base.sanitize_sql_for_assignment(...)
  end
end
