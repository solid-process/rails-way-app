# frozen_string_literal: true

require "test_helper"

class APIV1UserTokensTest < ActionDispatch::IntegrationTest
  test "#update responds with 401 when API token is invalid" do
    headers = [ {}, api_v1_helper.authorization_header(SecureRandom.hex(20)) ].sample

    put(api_v1_helper.user__tokens_url, headers:)

    api_v1_helper.assert_response_with_error(:unauthorized)
  end

  test "#update refreshes user API token and responds with 200" do
    user = users(:one)

    assert_changes -> { user.user_token.reload.value } do
      put(api_v1_helper.user__tokens_url, headers: api_v1_helper.authorization_header(user))
    end

    json_data = api_v1_helper.assert_response_with_success(:ok)

    assert_equal 8, user.user_token.short.size
    assert_equal user.user_token.short, json_data["user_token"].split("_").first
  end
end
