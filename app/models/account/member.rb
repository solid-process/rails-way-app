# frozen_string_literal: true

class Account::Member
  include ActiveModel::API
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :user
  attribute :user_id, :integer
  attribute :user_token, :string
  attribute :account_id, :integer
  attribute :task_list_id, :integer

  validates :user_token, presence: true, unless: :user_id?

  with_options numericality: { only_integer: true, greater_than: 0 } do
    validates :user_id, presence: true, unless: :user_token?
    validates :account_id, allow_nil: true
    validates :task_list_id, allow_nil: true
  end

  validate :user_id_and_user_token_cannot_be_present_at_the_same_time

  def self.authorize(params)
    new(params).tap { Authorization.new(_1).authorize! }
  end

  def authorized? = user? && account_id? && task_list_id?

  def user? = user.present?
  def user_id? = user_id.present?
  def user_token? = user_token.present?

  def account? = account.present?
  def account_id? = account_id.present?

  def task_list? = task_list.present?
  def task_list_id? = task_list_id.present?

  def account
    return @account if defined?(@account)

    @account = account_id.try { user&.accounts&.find_by(id: _1) }
  end

  def task_lists
    return @task_lists if defined?(@task_lists)

    @task_lists = account&.task_lists || Task::List.none
  end

  def task_list
    return @task_list if defined?(@task_list)

    @task_list = task_lists.find_by(id: task_list_id)
  end

  def task_items
    task_list&.items || Task::Item.none
  end

  private

  def user_id_and_user_token_cannot_be_present_at_the_same_time
    return unless user_id? && user_token?

    errors.add(:user_id, "cannot be present when user_token is present")
  end
end
