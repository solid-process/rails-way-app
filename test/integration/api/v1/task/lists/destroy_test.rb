# frozen_string_literal: true

require "test_helper"

class APIV1TaskListsDestroyTest < ActionDispatch::IntegrationTest
  test "#destroy responds with 401 when API token is invalid" do
    headers = [ {}, api_v1_helper.authorization_header(SecureRandom.hex(20)) ].sample

    delete(api_v1_helper.task__list_url(task_lists(:one_inbox), format: :json), headers:)

    api_v1_helper.assert_response_with_error(:unauthorized)
  end

  test "#destroy responds with 404 when task list is not found" do
    user = users(:one)

    delete(api_v1_helper.task__list_url(Task::List.maximum(:id) + 1, format: :json), headers: api_v1_helper.authorization_header(user))

    assert_response :not_found
  end

  test "#destroy responds with 403 when trying to destroy the inbox task list" do
    user = users(:one)

    delete(api_v1_helper.task__list_url(task_lists(:one_inbox), format: :json), headers: api_v1_helper.authorization_header(user))

    api_v1_helper.assert_response_with_error(:forbidden)
  end

  test "#destroy responds with 204" do
    user = users(:one)

    task_list = member!(user).account.task_lists.create!(name: "Bar")

    assert_difference -> { member!(user).account.task_lists.count }, -1 do
      delete(api_v1_helper.task__list_url(task_list, format: :json), headers: api_v1_helper.authorization_header(user))
    end

    assert_response :no_content
  end
end
