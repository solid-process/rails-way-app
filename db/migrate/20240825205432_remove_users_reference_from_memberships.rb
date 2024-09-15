# frozen_string_literal: true

class RemoveUsersReferenceFromMemberships < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :uuid, :string

    add_index :users, :uuid, unique: true

    add_column :memberships, :member_id, :bigint

    reversible do |dir|
      dir.up do
        User.find_each do |user|
          user.update!(uuid: ::UUID.generate)

          member = Account::Member.create!(uuid: user.uuid)

          Account::Membership.where(user_id: user.id).update_all(member_id: member.id)
        end
      end
    end

    change_column_null :users, :uuid, false

    add_foreign_key :memberships, :account_members, column: :member_id

    change_column_null :memberships, :member_id, false

    remove_reference :memberships, :user, foreign_key: true
  end
end
