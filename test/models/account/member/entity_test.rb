# frozen_string_literal: true

require "test_helper"

class Account::Member::EntityTest < ActiveSupport::TestCase
  test "validations" do
    uuid = account_members(:one).uuid

    member = Account::Member::Entity.new

    assert_not_predicate member, :valid?

    member.uuid = uuid

    assert_predicate member, :valid?

    member.uuid = "foo"

    assert_not_predicate member, :valid?

    member.uuid = uuid
    member.task_list_id = [ 0, -1 ].sample

    assert_not_predicate member, :valid?

    member.task_list_id = 1

    assert_predicate member, :valid?

    member.account_id = [ 0, -1 ].sample

    assert_not_predicate member, :valid?

    member.account_id = 1

    assert_predicate member, :valid?
  end
end
