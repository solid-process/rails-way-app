# frozen_string_literal: true

require "test_helper"

class WebGuestSignInTest < ActionDispatch::IntegrationTest
  test "guest signs in with invalid data" do
    get(web_helper.new_user__session_url)

    assert_response :ok

    assert_select("h2", "Please sign in")

    params = { user: { email: "foo@", password: "123" } }

    post(web_helper.user__sessions_url, params:)

    assert_response :unprocessable_entity

    assert_select("h2", "Please sign in")

    assert_select(".notice", "Invalid email or password. Please try again.")
  end

  test "guest signs in with valid data" do
    params = { user: { email: users(:one).email, password: "123123123" } }

    post(web_helper.user__sessions_url, params:)

    assert_redirected_to web_helper.task__items_url(task_lists(:one_inbox))

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "You have successfully signed in!")

    assert User.exists?(email: params.dig(:user, :email), uuid: session[:user_uuid])
  end
end
