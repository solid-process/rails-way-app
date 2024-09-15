# frozen_string_literal: true

require "simplecov"
SimpleCov.start "rails" do
  add_filter "/lib/"
end

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module UserTokensForTesting
  OPTIONS = {
    "one" => "Bh3ok8BL_XTNYFvwaRATjSoS3o5zjeQ4gWpQuUjd3",
    "two" => "dSNZRXsU_QAB7obbYzBZ9NPwD3suoQNxiSP8N2zPn"
  }.freeze

  def self.[](user)
    OPTIONS.fetch(user.email.split("@").first)
  end
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    parallelize_setup do |worker|
      SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}"
    end

    parallelize_teardown do |worker|
      SimpleCov.result
    end

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def member!(user) = user

    def create_task_list(account, name:)
      account.task_lists.create!(name: name)
    end

    def create_task(user, name: "Foo", completed: false, task_list: member!(user).inbox)
      task = task_list.task_items.create!(name:)

      completed ? complete_task(task) : task
    end

    def complete_task(task)
      task.tap { _1.update_column(:completed_at, Time.current) }
    end

    def incomplete_task(task)
      task.tap { _1.update_column(:completed_at, nil) }
    end

    def get_user_token(user)
      UserTokensForTesting[user]
    end
  end
end

class ActionDispatch::IntegrationTest
  class WebHelper
    attr_reader :test

    def initialize(test)
      @test = test
    end

    def sign_in(user, password: "123123123")
      test.post(user__sessions_url, params: { user: { email: user.email, password: } })

      test.assert_redirected_to task__items_url(user.inbox)

      test.follow_redirect!
    end

    def assert_unauthorized_access
      test.assert_redirected_to new_user__session_url

      test.follow_redirect!

      test.assert_response :ok

      test.assert_select(".notice", "You need to sign in or sign up before continuing.")
    end

    def user__session_url = test.user_session_url
    def user__sessions_url = test.user_sessions_url
    def new_user__session_url = test.new_user_session_url

    def user__registration_url = test.user_registration_url
    def user__registrations_url = test.user_registrations_url
    def new_user__registration_url = test.new_user_registration_url

    def user__password_url(...) = test.user_password_url(...)
    def user__passwords_url = test.user_passwords_url
    def new_user__password_url = test.new_user_password_url
    def edit_user__password_url(...) = test.edit_user_password_url(...)

    def user__tokens_url = test.user_settings_token_url
    def edit_user__token_url = test.edit_user_settings_token_url

    def user__profiles_url = test.user_settings_profile_url
    def edit_user__profile_url = test.edit_user_settings_profile_url

    def task__list_url(...) = test.task_list_url(...)
    def task__lists_url = test.task_lists_url
    def new_task__list_url = test.new_task_list_url
    def edit_task__list_url(...) = test.edit_task_list_url(...)

    def task__item_url(...) = test.task_list_item_url(...)
    def task__items_url(...) = test.task_list_items_url(...)
    def new_task__item_url(...) = test.new_task_list_item_url(...)
    def edit_task__item_url(...) = test.edit_task_list_item_url(...)
  end

  class APIV1Helper
    attr_reader :test

    def initialize(test)
      @test = test
    end

    def authorization_header(arg)
      user_token = arg.is_a?(User) ? UserTokensForTesting[arg] : arg

      { "Authorization" => "Bearer #{user_token}" }
    end

    def assert_response_with_error(status)
      test.assert_response(status)

      json_response = test.response.parsed_body.with_indifferent_access

      test.assert_equal "error", json_response["status"]
      test.assert_kind_of String, json_response["message"]
      test.assert_kind_of Hash, json_response["details"]

      json_response
    end

    def assert_response_with_success(status)
      test.assert_response(status)

      json_response = test.response.parsed_body.with_indifferent_access

      test.assert_equal "success", json_response["status"]

      json_data = json_response["data"]

      case json_response["type"]
      when "object" then test.assert_kind_of(Hash, json_data)
      when "collection" then test.assert_kind_of(Array, json_data)
      else test.assert_equal([ "status" ], json_response.keys)
      end

      json_data
    end

    def user__sessions_url = test.user_sessions_url(format: :json)

    def user__registration_url = test.user_registration_url(format: :json)
    def user__registrations_url = test.user_registrations_url(format: :json)

    def user__password_url(...) = test.user_password_url(...)
    def user__passwords_url = test.user_passwords_url(format: :json)

    def user__tokens_url = test.user_settings_token_url(format: :json)

    def user__profiles_url = test.user_settings_profile_url(format: :json)

    def task__list_url(...) = test.task_list_url(...)
    def task__lists_url = test.task_lists_url(format: :json)

    def task__item_url(...) = test.task_list_item_url(...)
    def task__items_url(...) = test.task_list_items_url(...)
    def complete_task__item_url(...) = test.task_list_items_complete_url(...)
    def incomplete_task__item_url(...) = test.task_list_items_incomplete_url(...)
  end

  def web_helper
    WebHelper.new(self)
  end

  def api_v1_helper
    APIV1Helper.new(self)
  end
end
