# frozen_string_literal: true

require "test_helper"

class WebTaskItemsEditingTest < ActionDispatch::IntegrationTest
  test "guest tries to access new task form" do
    get(web_helper.edit_task__item_url(task_lists(:one_inbox), task_items(:one)))

    web_helper.assert_unauthorized_access
  end

  test "guest tries to create a task" do
    put(
      web_helper.task__item_url(task_lists(:one_inbox), task_items(:one)),
      params: { task_item: { name: "Foo" } }
    )

    web_helper.assert_unauthorized_access
  end

  test "user tries to update a task from another user" do
    user = users(:one)
    task = task_items(:two)

    web_helper.sign_in(user)

    put(web_helper.task__item_url(task.list, task), params: { task_item: { name: "Foo" } })

    assert_response :not_found
  end

  test "user updates a task with valid data" do
    user = users(:one)
    task = task_items(:one)

    web_helper.sign_in(user)

    get(web_helper.edit_task__item_url(task.list, task))

    assert_response :ok

    assert_select("h2", "Editing task item")

    assert_select("input[type=\"text\"][value=\"#{task.name}\"]")

    assert_select("input[type=\"checkbox\"]:not(checked)")

    put(
      web_helper.task__item_url(member!(user).inbox, task),
      params: { task_item: { name: "Bar", completed: true } }
    )

    assert_redirected_to web_helper.task__items_url(member!(user).inbox)

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "Task item was successfully updated.")

    assert_select("td", /Bar/)

    get(web_helper.edit_task__item_url(task.list, task))

    assert_select("input[type=\"checkbox\"][checked]")
  end

  test "user updates a task with invalid data" do
    user = users(:one)
    task = task_items(:one)

    web_helper.sign_in(user)

    put(web_helper.task__item_url(task.list, task), params: { task_item: { name: "" } })

    assert_response :unprocessable_entity

    assert_select("li", "Name can't be blank")
  end
end
