# frozen_string_literal: true

require "test_helper"

class APIV1TaskListsCreateTest < ActionDispatch::IntegrationTest
  test "#create responds with 401 when API token is invalid" do
    headers = [ {}, api_v1_helper.authorization_header(SecureRandom.hex(20)) ].sample

    post(api_v1_helper.task__lists_url, headers:)

    api_v1_helper.assert_response_with_error(:unauthorized)
  end

  test "#create responds with 400 when params are missing" do
    params = [ {}, { task_list: {} }, { task_list: nil } ].sample

    post(api_v1_helper.task__lists_url, params:, headers: api_v1_helper.authorization_header(users(:one)))

    api_v1_helper.assert_response_with_error(:bad_request)
  end

  test "#create responds with 422 when name is invalid" do
    user = users(:one)

    params = { task_list: { name: [ nil, "" ].sample } }

    post(api_v1_helper.task__lists_url, params:, headers: api_v1_helper.authorization_header(user))

    api_v1_helper.assert_response_with_error(:unprocessable_entity)
  end

  test "#create responds with 201 when task list is created" do
    user = users(:one)

    params = { task_list: { name: "Foo" } }

    assert_difference -> { member!(user).account.task_lists.count } do
      post(api_v1_helper.task__lists_url, params:, headers: api_v1_helper.authorization_header(user))
    end

    json_data = api_v1_helper.assert_response_with_success(:created)

    assert_equal "Foo", json_data["name"]

    assert_equal(api_v1_helper.task__list_url(json_data["id"]), response.headers["location"])
  end
end
