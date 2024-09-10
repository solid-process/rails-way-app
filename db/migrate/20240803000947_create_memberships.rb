# frozen_string_literal: true

class CreateMemberships < ActiveRecord::Migration[7.2]
  def change
    create_table :memberships do |t|
      t.string :role, null: false, limit: 16
      t.references :user, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.index [ :account_id, :user_id ], unique: true

      t.timestamps
    end
  end
end
