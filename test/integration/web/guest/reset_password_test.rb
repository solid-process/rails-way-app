# frozen_string_literal: true

require "test_helper"

class WebGuestResetPasswordTest < ActionDispatch::IntegrationTest
  test "guest tries to reset the password with an invalid email" do
    get(web_helper.new_user__password_url)

    assert_response :ok

    assert_select("h2", "Forgot your password?")

    assert_enqueued_emails 0 do
      post(web_helper.user__passwords_url, params: { user: { email: "foo@" } })
    end

    assert_redirected_to web_helper.new_user__session_url

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "Check your email to reset your password.")
  end

  test "guest tries to the reset password with an existing email" do
    emails = capture_emails do
      post(web_helper.user__passwords_url, params: { user: { email: users(:one).email } })
    end

    assert_equal 1, emails.size

    assert_equal "Reset your password", emails.first.subject

    assert_redirected_to web_helper.new_user__session_url

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "Check your email to reset your password.")
  end

  test "guest uses an invalid token to reset the password" do
    get(web_helper.edit_user__password_url(SecureRandom.hex))

    assert_redirected_to web_helper.new_user__password_url

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "Invalid or expired token.")
  end

  test "guest resets the password with valid token and invalid data" do
    user = users(:one)

    emails = capture_emails do
      post(web_helper.user__passwords_url, params: { user: { email: user.email } })

      assert_redirected_to web_helper.new_user__session_url
    end

    assert_equal 1, emails.size

    token = emails.first.parts.last.to_s.match(%r{users/(.*)/password})[1]

    get(web_helper.edit_user__password_url(id: token))

    assert_response :ok

    params = { user: { password: "321", password_confirmation: "123" } }

    put(web_helper.user__password_url(id: token), params:)

    assert_response :unprocessable_entity

    assert_select("h2", "Reset your password")

    assert_select("li", "Password is too short (minimum is 8 characters)")
    assert_select("li", "Password confirmation doesn't match Password")
  end

  test "guest resets the password with valid token and data" do
    user = users(:one)

    emails = capture_emails do
      post(web_helper.user__passwords_url, params: { user: { email: user.email } })

      assert_redirected_to web_helper.new_user__session_url
    end

    assert_equal 1, emails.size

    token = emails.first.parts.last.to_s.match(%r{users/(.*)/password})[1]

    get(web_helper.edit_user__password_url(token))

    assert_response :ok

    params = { user: { password: "321321321", password_confirmation: "321321321" } }

    put(web_helper.user__password_url(token), params:)

    assert_redirected_to web_helper.new_user__session_url

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "Your password has been reset successfully. Please sign in.")

    user.reload

    assert_equal BCrypt::Password.new(user.password_digest), "321321321"
  end
end
