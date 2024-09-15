# frozen_string_literal: true

require "test_helper"

class WebUserSettingsAccountDeletionTest < ActionDispatch::IntegrationTest
  test "guest account deletion" do
    delete(web_helper.user__registration_url)

    web_helper.assert_unauthorized_access
  end

  test "user account deletion" do
    user = users(:one)

    web_helper.sign_in(user)

    get(web_helper.edit_user__profile_url)

    assert_select("h2", "Account deletion")
    assert_select("button", "Delete account")

    assert_difference(
      -> { User.count } => -1,
      -> { Account.count } => -1,
      -> { Account::Membership.count } => -1,
      -> { Account::Task::List.count } => -1,
      -> { User::Token.count } => -1
    ) do
      delete(web_helper.user__registration_url)
    end

    assert_redirected_to root_url

    follow_redirect!

    assert_response :ok

    assert_select(".notice", "Your account has been deleted.")

    assert_nil User.find_by(id: user.id)
  end
end
