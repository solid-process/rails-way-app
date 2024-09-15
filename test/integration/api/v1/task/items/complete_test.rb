# frozen_string_literal: true

require "test_helper"

class APIV1TaskItemsCompleteTest < ActionDispatch::IntegrationTest
  test "#update responds with 401 when API token is invalid" do
    user = users(:one)
    task = task_items(:one)
    headers = [ {}, api_v1_helper.authorization_header(SecureRandom.hex(20)) ].sample

    put(api_v1_helper.complete_task__item_url(member!(user).inbox, task, format: :json), headers:)

    api_v1_helper.assert_response_with_error(:unauthorized)
  end

  test "#update responds with 404 when task list is not found" do
    user = users(:one)
    task = task_items(:one)

    url = api_v1_helper.complete_task__item_url(Task::List.maximum(:id) + 1, task.id, format: :json)

    put(url, headers: api_v1_helper.authorization_header(user))

    api_v1_helper.assert_response_with_error(:not_found)
  end

  test "#update responds with 404 when task is not found" do
    user = users(:one)

    url = api_v1_helper.complete_task__item_url(member!(user).inbox, Task::Item.maximum(:id) + 1, format: :json)

    put(url, headers: api_v1_helper.authorization_header(user))

    api_v1_helper.assert_response_with_error(:not_found)
  end

  test "#update responds with 404 when task list belongs to another user" do
    user = users(:one)
    task = task_items(:two)

    put(
      api_v1_helper.complete_task__item_url(task.list, task, format: :json),
      headers: api_v1_helper.authorization_header(user)
    )

    api_v1_helper.assert_response_with_error(:not_found)
  end

  test "#update responds with 200 when task is marked as completed" do
    user = users(:one)

    task = task_items(:one).then { incomplete_task(_1) }

    assert_changes -> { task.reload.completed_at } do
      put(
        api_v1_helper.complete_task__item_url(member!(user).inbox, task, format: :json),
        headers: api_v1_helper.authorization_header(user)
      )
    end

    assert_kind_of(Time, task.completed_at)

    json_data = api_v1_helper.assert_response_with_success(:ok)

    assert_equal(task.id, json_data[:id])
    assert_not_nil(json_data[:completed_at])
  end
end
