# frozen_string_literal: true

require "test_helper"

class APIV1UserPasswordsResettingsTest < ActionDispatch::IntegrationTest
  test "#create responds with 400 when params are missing" do
    params = [ {}, { user: {} }, { user: nil } ].sample

    post(api_v1_helper.user__passwords_resetting_url, params:)

    api_v1_helper.assert_response_with_error(:bad_request)
  end

  test "#create responds with 200 when the email is not found" do
    email = "#{SecureRandom.hex}@email.com"

    post(api_v1_helper.user__passwords_resetting_url, params: { user: { email: } })

    api_v1_helper.assert_response_with_success(:ok)
  end

  test "#create sends reset password email and responds with 200" do
    user = users(:one)

    emails = capture_emails do
      post(api_v1_helper.user__passwords_resetting_url, params: { user: { email: user.email } })
    end

    assert_equal 1, emails.size
    assert_equal "Reset your password", emails.first.subject

    api_v1_helper.assert_response_with_success(:ok)
  end

  test "#update responds with 422 when token is invalid" do
    token = SecureRandom.hex

    params = {
      user: {
        password: "123123123",
        password_confirmation: "123123123"
      }
    }

    put(api_v1_helper.user__passwords_resetting_url(token:), params:)

    api_v1_helper.assert_response_with_error(:unprocessable_entity) => {message:}

    assert_equal "Invalid token", message
  end

  test "#update responds with 422 when passwords are invalid" do
    user = users(:one)

    token = user.generate_token_for(:reset_password)

    params = {
      user: {
        password: [ "1", "123", "1234567" ].sample,
        password_confirmation: [ "1", "123", "1234567" ].sample
      }
    }

    put(api_v1_helper.user__passwords_resetting_url(token:), params:)

    api_v1_helper.assert_response_with_error(:unprocessable_entity)
  end

  test "#update updates user password and responds with 200" do
    user = users(:one)

    emails = capture_emails do
      post(api_v1_helper.user__passwords_resetting_url, params: { user: { email: user.email } })
    end

    token = emails.first.parts.last.to_s.match(%r{passwords/(.*)/edit})[1]

    params = {
      user: {
        password: "321321321",
        password_confirmation: "321321321"
      }
    }

    put(api_v1_helper.user__passwords_resetting_url(token:), params:)

    api_v1_helper.assert_response_with_success(:ok)
  end
end
