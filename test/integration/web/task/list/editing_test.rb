# frozen_string_literal: true

require "test_helper"

class WebTaskListsEditingTest < ActionDispatch::IntegrationTest
  test "guest tries to access edit task list form" do
    user = users(:one)

    task_list = create_task_list(member!(user).account, name: "Foo")

    get(web_helper.edit_task__list_url(task_list))

    web_helper.assert_unauthorized_access
  end

  test "guest tries to update a task list" do
    user = users(:one)

    task_list = create_task_list(member!(user).account, name: "Foo")

    put(web_helper.task__list_url(task_list), params: { task_list: { name: "Bar" } })

    web_helper.assert_unauthorized_access
  end

  test "user tries to edit the inbox task list" do
    user = users(:one)

    web_helper.sign_in(user)

    get(web_helper.edit_task__list_url(member!(user).inbox))

    assert_redirected_to web_helper.task__lists_url

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "You cannot edit or delete the inbox.")
  end

  test "user tries to update the inbox task list" do
    user = users(:one)

    web_helper.sign_in(user)

    put(web_helper.task__list_url(member!(user).inbox), params: { task_list: { name: "Bar" } })

    assert_redirected_to web_helper.task__lists_url

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "You cannot edit or delete the inbox.")
  end

  test "user updates a task list with invalid data" do
    user = users(:one)
    task_list = create_task_list(member!(user).account, name: "Foo")

    web_helper.sign_in(user)

    get(web_helper.edit_task__list_url(task_list))

    assert_response :ok

    assert_select("h2", "Editing task list")

    assert_select("input[type=\"text\"][value=\"Foo\"]")

    put(web_helper.task__list_url(task_list), params: { task_list: { name: "" } })

    assert_response :unprocessable_entity

    assert_select("li", "Name can't be blank")
  end

  test "user updates a task list with valid data" do
    user = users(:one)
    task_list = create_task_list(member!(user).account, name: "Foo")

    web_helper.sign_in(user)

    get(web_helper.edit_task__list_url(task_list))

    assert_response :ok

    assert_select("h2", "Editing task list")

    assert_select("input[type=\"text\"][value=\"Foo\"]")

    put(web_helper.task__list_url(task_list), params: { task_list: { name: "Bar" } })

    assert_redirected_to web_helper.task__list_url(task_list)

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "Task list was successfully updated.")

    assert_select("td", "Bar")
  end

  test "user tries to update a task list from another user" do
    user1 = users(:one)
    user2 = users(:two)

    task_list2 = create_task_list(member!(user2).account, name: "Foo")

    web_helper.sign_in(user1)

    put(web_helper.task__list_url(task_list2), params: { task_list: { name: "Bar" } })

    assert_response :not_found
  end
end
