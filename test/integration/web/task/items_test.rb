# frozen_string_literal: true

require "test_helper"

class WebTaskItemsTest < ActionDispatch::IntegrationTest
  test "guest tries to access all tasks" do
    get(web_helper.task__items_url(task_lists(:one_inbox)))

    web_helper.assert_unauthorized_access
  end

  test "guest tries to access completed tasks" do
    get(web_helper.task__items_url(task_lists(:one_inbox), filter: "completed"))

    web_helper.assert_unauthorized_access
  end

  test "guest tries to access incomplete tasks" do
    get(web_helper.task__items_url(task_lists(:one_inbox), filter: "incomplete"))

    web_helper.assert_unauthorized_access
  end

  test "user access all tasks" do
    user = users(:one)

    create_task(user, name: "Foo", completed: true)

    web_helper.sign_in(user)

    get(web_helper.task__items_url(member!(user).inbox))

    assert_response :ok

    assert_select("p", /All \(2\)/)

    assert_equal 1, css_select("a[title=\"Mark as complete\"]").size
    assert_equal 1, css_select("a[title=\"Mark as incomplete\"]").size

    links = css_select("[data-turbo-confirm][data-turbo-method=\"delete\"]")

    assert_equal 2, links.size

    links.each do |link|
      delete(link["href"])

      assert_redirected_to web_helper.task__items_url(task_lists(:one_inbox))

      follow_redirect!

      assert_response :ok
    end

    assert_equal 0, css_select("[data-method=\"put\"]").size

    assert_select(".notice", /You don't have any task items. Create one by touching the.*\+ New item.*button./)
  end

  test "user access completed tasks" do
    user = users(:one)

    task_items(:one).then { complete_task(_1) }

    web_helper.sign_in(user)

    get(web_helper.task__items_url(member!(user).inbox, filter: "completed"))

    assert_response :ok

    assert_select("p", /Completed \(1\)/)

    links = css_select("a[data-turbo-method=\"put\"]")

    assert_equal 1, links.size

    link = links.first

    assert_equal("Mark as incomplete", link["title"])

    put(link["href"])

    assert_redirected_to web_helper.task__items_url(member!(user).inbox, filter: "completed")

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "Task item was successfully marked as incomplete.")

    assert_equal 0, css_select("a[data-method=\"put\"]").size

    assert_select(".notice", "You don't have any completed tasks. Keep up the good work!")

    get(web_helper.task__items_url(member!(user).inbox, filter: "incomplete"))

    links = css_select("[data-turbo-confirm][data-turbo-method=\"delete\"]")

    assert_equal 1, links.size

    delete(links.first["href"])

    assert_redirected_to web_helper.task__items_url(member!(user).inbox, filter: "incomplete")

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "Task item was successfully destroyed.")

    assert_equal 0, css_select("[data-turbo-confirm][data-turbo-method=\"delete\"]").size

    assert_select(".notice", /You don't have any task items. Create one by touching the.*\+ New item.*button./)
  end

  test "user access incomplete tasks" do
    user = users(:one)

    web_helper.sign_in(user)

    get(web_helper.task__items_url(member!(user).inbox, filter: "incomplete"))

    assert_response :ok

    assert_select("p", /Incomplete \(1\)/)

    links = css_select("a[data-turbo-method=\"put\"]")

    assert_equal 1, links.size

    link = links.first

    assert_equal("Mark as complete", link["title"])

    put(link["href"])

    assert_redirected_to web_helper.task__items_url(member!(user).inbox, filter: "incomplete")

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "Task item was successfully marked as completed.")

    assert_equal 0, css_select("a[data-turbo-method=\"put\"]").size

    assert_select(".notice", "You don't have any incomplete tasks. Great job!")

    get(web_helper.task__items_url(member!(user).inbox, filter: "completed"))

    links = css_select("[data-turbo-confirm][data-turbo-method=\"delete\"]")

    assert_equal 1, links.size

    delete(links.first["href"])

    assert_redirected_to web_helper.task__items_url(member!(user).inbox, filter: "completed")

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "Task item was successfully destroyed.")

    assert_equal 0, css_select("[data-method=\"put\"]").size

    assert_select(".notice", /You don't have any task items. Create one by touching the.*\+ New item.*button./)
  end
end
