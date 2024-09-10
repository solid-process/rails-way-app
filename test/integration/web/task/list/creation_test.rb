# frozen_string_literal: true

require "test_helper"

class WebTaskListsCreationTest < ActionDispatch::IntegrationTest
  test "guest tries to access new task list form" do
    get(web_helper.new_task__list_url)

    web_helper.assert_unauthorized_access
  end

  test "guest tries to create a task list" do
    post(web_helper.task__lists_url, params: { task_list: { name: "Foo" } })

    web_helper.assert_unauthorized_access
  end

  test "user creates a task list with invalid data" do
    user = users(:one)

    web_helper.sign_in(user)

    get(web_helper.new_task__list_url)

    assert_response :ok

    assert_select("h2", "New task list")

    assert_no_difference(-> { member!(user).account.task_lists.count }) do
      post(web_helper.task__lists_url, params: { task_list: { name: "" } })
    end

    assert_response :unprocessable_entity

    assert_select("li", "Name can't be blank")
  end

  test "user creates a task list with valid data" do
    user = users(:one)

    web_helper.sign_in(user)

    assert_difference(-> { member!(user).account.task_lists.count }) do
      post(web_helper.task__lists_url, params: { task_list: { name: "Foo" } })
    end

    assert_redirected_to web_helper.task__list_url(member!(user).account.task_lists.last)

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "Task list was successfully created.")

    assert_select("td", "Foo")
  end
end
