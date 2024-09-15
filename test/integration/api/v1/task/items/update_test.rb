# frozen_string_literal: true

require "test_helper"

class APIV1TaskItemsUpdateTest < ActionDispatch::IntegrationTest
  test "#update responds with 401 when API token is invalid" do
    user = users(:one)
    task = task_items(:one)
    params = { task_item: { name: "Foo" } }
    headers = [ {}, api_v1_helper.authorization_header(SecureRandom.hex(20)) ].sample

    put(api_v1_helper.task__item_url(member!(user).inbox, task), params:, headers:)

    api_v1_helper.assert_response_with_error(:unauthorized)
  end

  test "#update responds with 400 when params are missing" do
    user = users(:one)
    task = task_items(:one)
    params = [ {}, { task_item: {} }, { task: nil } ].sample

    put(
      api_v1_helper.task__item_url(member!(user).inbox, task),
      headers: api_v1_helper.authorization_header(user),
      params:
    )

    api_v1_helper.assert_response_with_error(:bad_request)
  end

  test "#update responds with 404 when task list is not found" do
    user = users(:one)
    task = task_items(:one)
    params = { task_item: { name: "Foo" } }

    url = api_v1_helper.task__item_url(Account::Task::List.maximum(:id) + 1, task.id)

    put(url, params:, headers: api_v1_helper.authorization_header(user))

    api_v1_helper.assert_response_with_error(:not_found)
  end

  test "#update responds with 404 when task is not found" do
    user = users(:one)
    params = { task_item: { name: "Foo" } }

    url = api_v1_helper.task__item_url(member!(user).inbox, Account::Task::Item.maximum(:id) + 1)

    put(url, params:, headers: api_v1_helper.authorization_header(user))

    api_v1_helper.assert_response_with_error(:not_found)
  end

  test "#update responds with 404 when task list belongs to another user" do
    user = users(:one)
    task = task_items(:two)
    params = { task_item: { name: "Foo" } }

    put(
      api_v1_helper.task__item_url(task.list, task),
      headers: api_v1_helper.authorization_header(user),
      params:
    )

    api_v1_helper.assert_response_with_error(:not_found)
  end

  test "#update responds with 422 when name is invalid" do
    user = users(:one)
    task = task_items(:one)
    params = { task_item: { name: [ nil, "" ].sample } }

    put(
      api_v1_helper.task__item_url(member!(user).inbox, task),
      headers: api_v1_helper.authorization_header(user),
      params:
    )

    api_v1_helper.assert_response_with_error(:unprocessable_entity)
  end

  test "#update responds with 200 when task is updated" do
    user = users(:one)
    task = task_items(:one)
    params = { task_item: { name: SecureRandom.hex } }

    put(
      api_v1_helper.task__item_url(member!(user).inbox, task),
      params:,
      headers: api_v1_helper.authorization_header(user)
    )

    json_data = api_v1_helper.assert_response_with_success(:ok)

    updated_task = member!(user).inbox.items.find(json_data["id"])

    assert_equal params[:task_item][:name], updated_task.name
  end

  test "#update responds with 200 when marking task as completed" do
    user = users(:one)
    task = task_items(:one)
    params = { task_item: { completed: [ true, 1, "1", "true" ].sample } }

    put(
      api_v1_helper.task__item_url(member!(user).inbox, task),
      headers: api_v1_helper.authorization_header(user),
      params:
    )

    json_data = api_v1_helper.assert_response_with_success(:ok)

    updated_task = member!(user).inbox.items.find(json_data["id"])

    assert updated_task.completed_at.present?
  end

  test "#update responds with 200 when marking task as incomplete" do
    user = users(:one)
    task = task_items(:one).then { complete_task(_1) }

    params = { task_item: { completed: [ false, 0, "0", "false" ].sample } }

    put(
      api_v1_helper.task__item_url(member!(user).inbox, task),
      headers: api_v1_helper.authorization_header(user),
      params:
    )

    json_data = api_v1_helper.assert_response_with_success(:ok)

    updated_task = member!(user).inbox.items.find(json_data["id"])

    assert updated_task.completed_at.blank?
  end
end
