# frozen_string_literal: true

require "test_helper"

class WebTaskListsTest < ActionDispatch::IntegrationTest
  test "guest tries to access all task lists" do
    get(web_helper.task__lists_url)

    web_helper.assert_unauthorized_access
  end

  test "user views all task lists" do
    user = users(:one)

    create_task_list(member!(user).account, name: "Foo")

    web_helper.sign_in(user)

    get(web_helper.task__lists_url)

    assert_response :ok

    assert_select("td", /Inbox/)
    assert_select("td", "Foo")
  end

  test "user destroys a task list" do
    user = users(:one)

    create_task_list(member!(user).account, name: "Foo")

    web_helper.sign_in(user)

    get(web_helper.task__lists_url)

    assert_response :ok

    links = css_select("a[data-turbo-confirm][data-method=\"delete\"]")

    assert_equal 1, links.size

    delete(links.first["href"])

    assert_redirected_to web_helper.task__lists_url

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "Task list was successfully destroyed.")
  end

  test "user tries to destroy the inbox task list" do
    user = users(:one)

    web_helper.sign_in(user)

    delete(web_helper.task__list_url(member!(user).inbox))

    assert_redirected_to web_helper.task__lists_url

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "You cannot edit or delete the inbox.")
  end

  test "user tries to destroy a task list from another user" do
    user = users(:one)
    task_list = task_lists(:two_inbox)

    web_helper.sign_in(user)

    delete(web_helper.task__list_url(task_list))

    assert_response :not_found
  end
end
