# frozen_string_literal: true

require "test_helper"

class APIV1UserRegistrationsTest < ActionDispatch::IntegrationTest
  test "#create responds with 400 when params are missing" do
    params = [ {}, { user: {} }, { user: nil } ].sample

    post(api_v1_helper.user__registrations_url, params:)

    api_v1_helper.assert_response_with_error(:bad_request)
  end

  test "#create responds with 422 when email is invalid" do
    email = [ "@", "invalid", "invalid@", "" ].sample

    params = {
      user: {
        email: email,
        password: "123123123",
        password_confirmation: "123123123"
      }
    }

    post(api_v1_helper.user__registrations_url, params:)

    api_v1_helper.assert_response_with_error(:unprocessable_entity)
  end

  test "#create responds with 422 when password is invalid" do
    password = [ "", "123", "1234567" ].sample
    password_confirmation = [ "", "123", "1234567" ].sample

    params = { user: { email: "email@example.com", password:, password_confirmation: } }

    post(api_v1_helper.user__registrations_url, params:)

    api_v1_helper.assert_response_with_error(:unprocessable_entity)
  end

  test "#create responds with 422 when password does not match password confirmation" do
    password = "12345678"
    password_confirmation = "12345677"

    params = { user: { email: "email@example.com", password:, password_confirmation: } }

    post(api_v1_helper.user__registrations_url, params:)

    api_v1_helper.assert_response_with_error(:unprocessable_entity)
  end

  test "#create responds with 201 when params are valid" do
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
      -> { Account::Membership.count } => 1,
      -> { Account::Task::List.count } => 1,
      -> { User::Token.count } => 1
    ) do
      post(api_v1_helper.user__registrations_url, params:)
    end

    json_data = api_v1_helper.assert_response_with_success(:created)

    assert_equal(
      User.find_by(email: params[:user][:email]).token.short,
      json_data["user_token"].split("_").first
    )
  end

  test "#destroy responds with 401 when API token is invalid" do
    headers = [ {}, api_v1_helper.authorization_header(SecureRandom.hex(20)) ].sample

    delete(api_v1_helper.user__registration_url, headers:)

    api_v1_helper.assert_response_with_error(:unauthorized)
  end

  test "#destroy deletes user account and responds with 200" do
    user = users(:one)

    assert_difference(
      -> { User.count } => -1,
      -> { Account.count } => -1,
      -> { Account::Membership.count } => -1,
      -> { Account::Task::List.count } => -1,
      -> { User::Token.count } => -1
    ) do
      delete(api_v1_helper.user__registration_url, headers: api_v1_helper.authorization_header(user))
    end

    assert_response(:no_content)

    assert_nil User.find_by(id: user.id)
  end
end
