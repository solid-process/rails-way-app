# frozen_string_literal: true

require "test_helper"

class CurrentTest < ActiveSupport::TestCase
  test ".member! validations" do
    user_id = users(:one).id
    user_token = get_user_token(users(:one))

    Current.member!(user_id: nil, user_token:)

    assert_predicate Current, :member?

    Current.member!(user_id:, user_token: nil)

    assert_predicate Current, :member?

    assert_raises(
      ArgumentError,
      "cannot be present when user_token is present"
    ) { Current.tap(&:reset).member!(user_id:, user_token:) }
  end

  test ".member!(user_id:)" do
    user = users(:one)

    create_task_list(member!(user).account, name: "Foo")

    Current.member!(user_id: user.id)

    assert_predicate Current, :member?

    assert_equal member!(user).account.id, Current.account_id
    assert_equal member!(user).inbox.id, Current.task_list_id
    assert_equal user.id, Current.user_id
    assert_nil Current.user_token

    assert_equal member!(user).account, Current.account
    assert_equal member!(user).inbox, Current.task_list
    assert_equal user, Current.user

    assert_equal user.task_lists, Current.task_lists
    assert_equal 2, Current.task_lists.size

    assert_predicate Current, :user_id?
    assert_predicate Current, :account_id?
    assert_predicate Current, :task_list_id?

    assert_predicate Current, :user?
    assert_predicate Current, :account?
    assert_predicate Current, :task_list?

    # ---

    user_id = User.maximum(:id) + 1

    Current.member!(user_id:)

    assert_not_predicate Current, :member?

    assert_equal user_id, Current.user_id
    assert_nil Current.user
    assert_nil Current.account_id
    assert_nil Current.task_list_id
    assert_nil Current.user_token
  end

  test ".member!(user_id:, account_id:)" do
    user = users(:one)
    account = accounts(:one)

    Current.member!(user_id: user.id, account_id: account.id)

    assert_predicate Current, :member?

    assert_equal user.id, Current.user_id
    assert_equal account.id, Current.account_id
    assert_equal account.inbox.id, Current.task_list_id
    assert_nil Current.user_token

    # ---

    Current.member!(user_id: user.id, account_id: accounts(:two).id)

    assert_not_predicate Current, :member?

    assert_equal user, Current.user
    assert_equal user.id, Current.user_id
    assert_nil Current.account_id
    assert_nil Current.task_list_id
    assert_nil Current.user_token

    # ---

    user_id = User.maximum(:id) + 1

    Current.member!(user_id:, account_id: account.id)

    assert_not_predicate Current, :member?

    assert_equal user_id, Current.user_id
    assert_nil Current.user
    assert_nil Current.account_id
    assert_nil Current.task_list_id
    assert_nil Current.user_token
  end

  test ".member!(user_id:, task_list_id:)" do
    user = users(:one)
    task_list = create_task_list(member!(user).account, name: "Foo")

    Current.member!(user_id: user.id, task_list_id: task_list.id)

    assert_predicate Current, :member?

    assert_equal user.id, Current.user_id
    assert_equal task_list.id, Current.task_list_id
    assert_equal task_list.account_id, Current.account_id
    assert_nil Current.user_token

    # ---

    Current.member!(user_id: user.id, task_list_id: task_lists(:two_inbox).id)

    assert_not_predicate Current, :member?

    assert_equal user, Current.user
    assert_equal user.id, Current.user_id
    assert_nil Current.account_id
    assert_nil Current.task_list_id
    assert_nil Current.user_token

    # ---

    user_id = User.maximum(:id) + 1

    Current.member!(user_id:, task_list_id: task_list.id)

    assert_not_predicate Current, :member?

    assert_equal user_id, Current.user_id
    assert_nil Current.user
    assert_nil Current.account_id
    assert_nil Current.task_list_id
    assert_nil Current.user_token
  end

  test ".member!(user_id:, account_id:, task_list_id:)" do
    user = users(:one)
    account = accounts(:one)
    task_list = create_task_list(account, name: "Foo")

    Current.member!(user_id: user.id, account_id: account.id, task_list_id: task_list.id)

    assert_predicate Current, :member?

    assert_equal user.id, Current.user_id
    assert_equal account.id, Current.account_id
    assert_equal task_list.id, Current.task_list_id
    assert_nil Current.user_token

    # ---

    Current.member!(user_id: user.id, account_id: accounts(:two).id, task_list_id: task_list.id)

    assert_not_predicate Current, :member?

    assert_equal user, Current.user
    assert_equal user.id, Current.user_id
    assert_nil Current.account_id
    assert_nil Current.task_list_id
    assert_nil Current.user_token

    # ---

    task_list_id = task_lists(:two_inbox).id

    Current.member!(user_id: user.id, account_id: account.id, task_list_id:)

    assert_not_predicate Current, :member?

    assert_equal user, Current.user
    assert_equal user.id, Current.user_id
    assert_nil Current.account_id
    assert_nil Current.task_list_id
    assert_nil Current.user_token
  end

  test ".member!(user_token:)" do
    user = users(:one)
    user_token = get_user_token(user)

    Current.member!(user_token:)

    assert_predicate Current, :member?

    assert_equal user_token, Current.user_token
    assert_equal member!(user).account.id, Current.account_id
    assert_equal member!(user).inbox.id, Current.task_list_id
    assert_equal user.id, Current.user_id
    assert_equal user, Current.user

    # ---

    user_token = SecureRandom.hex

    Current.member!(user_token:)

    assert_not_predicate Current, :member?

    assert_equal user_token, Current.user_token
    assert_nil Current.user
    assert_nil Current.user_id
    assert_nil Current.account_id
    assert_nil Current.task_list_id
  end

  test ".fetch_by with user_token and account_id" do
    user = users(:one)
    account = accounts(:one)
    user_token = get_user_token(user)

    Current.member!(user_token:, account_id: account.id)

    assert_predicate Current, :member?

    assert_equal user.id, Current.user_id
    assert_equal account.id, Current.account_id
    assert_equal account.inbox.id, Current.task_list_id

    # ---

    Current.member!(user_token:, account_id: accounts(:two).id)

    assert_not_predicate Current, :member?

    assert_equal user, Current.user
    assert_equal user.id, Current.user_id
    assert_nil Current.account_id
    assert_nil Current.task_list_id

    # ---

    Current.member!(user_token: SecureRandom.hex, account_id: account.id)

    assert_not_predicate Current, :member?

    assert_nil Current.user
    assert_nil Current.user_id
    assert_nil Current.account_id
    assert_nil Current.task_list_id
  end

  test ".fetch_by with user_token and task_list_id" do
    user = users(:one)
    task_list = create_task_list(member!(user).account, name: "Foo")
    user_token = get_user_token(user)

    Current.member!(user_token:, task_list_id: task_list.id)

    assert_predicate Current, :member?

    assert_equal user_token, Current.user_token
    assert_equal user.id, Current.user_id
    assert_equal task_list.id, Current.task_list_id
    assert_equal task_list.account_id, Current.account_id

    # ---

    Current.member!(user_token:, task_list_id: task_lists(:two_inbox).id)

    assert_not_predicate Current, :member?

    assert_equal user_token, Current.user_token
    assert_equal user, Current.user
    assert_equal user.id, Current.user_id
    assert_nil Current.account_id
    assert_nil Current.task_list_id

    # ---

    Current.member!(user_token: SecureRandom.hex, task_list_id: task_list.id)

    assert_not_predicate Current, :member?

    assert_not_nil Current.user_token
    assert_nil Current.user
    assert_nil Current.user_id
    assert_nil Current.account_id
    assert_nil Current.task_list_id
  end

  test ".fetch_by with user_token, account_id, and task_list_id" do
    user = users(:one)
    account = accounts(:one)
    task_list = create_task_list(account, name: "Foo")
    user_token = get_user_token(user)

    Current.member!(user_token:, account_id: account.id, task_list_id: task_list.id)

    assert_predicate Current, :member?

    assert_equal user_token, Current.user_token
    assert_equal user.id, Current.user_id
    assert_equal account.id, Current.account_id
    assert_equal task_list.id, Current.task_list_id

    # ---

    Current.member!(user_token:, account_id: accounts(:two).id, task_list_id: task_list.id)

    assert_not_predicate Current, :member?

    assert_equal user_token, Current.user_token
    assert_equal user, Current.user
    assert_equal user.id, Current.user_id
    assert_nil Current.account_id
    assert_nil Current.task_list_id

    # ---

    Current.member!(user_token: SecureRandom.hex, account_id: account.id, task_list_id: task_list.id)

    assert_not_predicate Current, :member?

    assert_not_nil Current.user_token
    assert_nil Current.user
    assert_nil Current.user_id
    assert_nil Current.account_id
    assert_nil Current.task_list_id
  end
end
