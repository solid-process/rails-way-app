# frozen_string_literal: true

class Account::Member
  class Entity
    include ActiveModel::API
    include ActiveModel::Attributes
    include ActiveModel::Validations

    attribute :record

    validates :uuid, presence: true, format: ::UUID::REGEXP

    attribute :uuid, :string
    attribute :account_id, :integer
    attribute :task_list_id, :integer

    with_options numericality: { only_integer: true, greater_than: 0 } do
      validates :account_id, allow_nil: true
      validates :task_list_id, allow_nil: true
    end

    def authorized? = record? && account_id? && task_list_id?

    def uuid? = uuid.present?
    def record? = record.present?

    def account? = account.present?
    def account_id? = account_id.present?

    def task_list? = task_list.present?
    def task_list_id? = task_list_id.present?

    def account
      return @account if defined?(@account)

      @account = account_id.try { record&.accounts&.find_by(id: _1) }
    end

    def task_lists
      return @task_lists if defined?(@task_lists)

      @task_lists = account&.task_lists || Account::Task::List.none
    end

    def task_list
      return @task_list if defined?(@task_list)

      @task_list = task_lists.find_by(id: task_list_id)
    end

    def task_items
      task_list&.items || Account::Task::Item.none
    end
  end
end
