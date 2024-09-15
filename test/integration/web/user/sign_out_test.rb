# frozen_string_literal: true

require "test_helper"

class WebUserSignOutTest < ActionDispatch::IntegrationTest
  test "guest signs out" do
    delete(web_helper.user__session_url)

    web_helper.assert_unauthorized_access
  end

  test "user signs out" do
    user = users(:one)

    web_helper.sign_in(user)

    delete(web_helper.user__session_url)

    assert_redirected_to web_helper.new_user__session_url

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "You have successfully signed out.")
  end
end
