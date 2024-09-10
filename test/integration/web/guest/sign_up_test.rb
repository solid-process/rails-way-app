# frozen_string_literal: true

require "test_helper"

class WebGuestSignUpTest < ActionDispatch::IntegrationTest
  test "guest signs up with invalid data" do
    get(web_helper.new_user__registration_url)

    assert_response :ok

    assert_select("h2", "Sign up")

    params = { user: { email: "foo@", password: "123", password_confirmation: "321" } }

    post(web_helper.user__registrations_url, params:)

    assert_response :unprocessable_entity

    assert_select("h2", "Sign up")

    assert_select("li", "Email is invalid")
    assert_select("li", "Password is too short (minimum is 8 characters)")
    assert_select("li", "Password confirmation doesn't match Password")
  end

  test "guest signs up with an email that is already taken" do
    params = {
      user: {
        email: users(:one).email,
        password: "123123123",
        password_confirmation: "123123123"
      }
    }

    post(web_helper.user__registrations_url, params:)

    assert_response :unprocessable_entity

    assert_select("h2", "Sign up")

    assert_select("li", "Email has already been taken")
  end

  test "guest signs up with valid data" do
    params = {
      user: {
        email: "email@example.com",
        password: "123123123",
        password_confirmation: "123123123"
      }
    }

    assert_difference(
      -> { User.count } => 1,
      -> { Account.count } => 1,
      -> { Membership.count } => 1,
      -> { TaskList.count } => 1,
      -> { UserToken.count } => 1
    ) do
      post(web_helper.user__registrations_url, params:)
    end

    assert_redirected_to web_helper.task__items_url(TaskList.inbox.last)

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "You have successfully registered!")

    assert User.exists?(email: params.dig(:user, :email), id: session[:user_id])
  end
end
