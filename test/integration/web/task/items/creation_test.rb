# frozen_string_literal: true

require "test_helper"

class WebTaskItemsCreationTest < ActionDispatch::IntegrationTest
  test "guest tries to access new task form" do
    get(web_helper.new_task__item_url(task_lists(:one_inbox)))

    web_helper.assert_unauthorized_access
  end

  test "guest tries to create a task" do
    post(web_helper.task__items_url(task_lists(:one_inbox)), params: { task: { name: "Foo" } })

    web_helper.assert_unauthorized_access
  end

  test "user creates a task with valid data" do
    user = users(:one)

    web_helper.sign_in(user)

    get(web_helper.new_task__item_url(member!(user).inbox))

    assert_response :ok

    assert_select("h2", "New task item")

    assert_difference(-> { member!(user).inbox.task_items.count }) do
      post(web_helper.task__items_url(member!(user).inbox), params: { task_item: { name: "Bar" } })
    end

    assert_redirected_to web_helper.task__items_url(member!(user).inbox)

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "Task item was successfully created.")

    assert_select("p", /All \(2\)/)

    assert_select("td", "Bar")
  end

  test "user creates a task with invalid data" do
    user = users(:one)

    web_helper.sign_in(user)

    assert_no_difference(-> { member!(user).inbox.task_items.count }) do
      post(web_helper.task__items_url(member!(user).inbox), params: { task_item: { name: "" } })
    end

    assert_response :unprocessable_entity

    assert_select("li", "Name can't be blank")
  end
end
