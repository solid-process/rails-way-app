# frozen_string_literal: true

require "test_helper"

class WebUserSettingsPasswordUpdatingTest < ActionDispatch::IntegrationTest
  test "guest tries to access the user profile" do
    get(web_helper.edit_user__profile_url)

    web_helper.assert_unauthorized_access
  end

  test "guest tries to update the password" do
    params = {
      user: {
        current_password: "password",
        password: "new_password",
        password_confirmation: "new_password"
      }
    }

    put(web_helper.user__profiles_url, params:)

    web_helper.assert_unauthorized_access
  end

  test "user profile access" do
    user = users(:one)

    web_helper.sign_in(user)

    get(web_helper.edit_user__profile_url)

    assert_select("label", "Email")
    assert_select("label", "New password")
    assert_select("label", "Password confirmation")

    email_inputs = assert_select("input[type='email']")

    assert_equal 1, email_inputs.size

    email_input = email_inputs.first

    assert email_input.has_attribute?("disabled")

    assert_equal user.email, email_input["value"]

    assert assert_select("[type=\"submit\"]").any? do |button|
      button["value"] == "Update Password"
    end
  end

  test "user tries to update the password with invalid data" do
    user = users(:one)

    web_helper.sign_in(user)

    params = {
      user: {
        password_challenge: "123123123",
        password: "newpass",
        password_confirmation: "new_pass"
      }
    }

    put(web_helper.user__profiles_url, params:)

    assert_response :unprocessable_entity

    assert_select("li", "Password confirmation doesn't match Password")
    assert_select("li", "Password is too short (minimum is 8 characters)")

    params = {
      user: {
        password_challenge: "password",
        password: "newpassword",
        password_confirmation: "newpassword"
      }
    }

    put(web_helper.user__profiles_url, params:)

    assert_response :unprocessable_entity

    assert_select("li", "Password challenge is invalid")
  end

  test "user tries to update the password with valid data" do
    user = users(:one)

    web_helper.sign_in(user)

    params = {
      user: {
        password_challenge: "123123123",
        password: "new_password",
        password_confirmation: "new_password"
      }
    }

    put(web_helper.user__profiles_url, params:)

    assert_redirected_to web_helper.edit_user__profile_url

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "Your password has been updated.")
  end
end
