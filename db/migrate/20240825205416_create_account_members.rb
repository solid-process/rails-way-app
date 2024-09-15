# frozen_string_literal: true

class CreateAccountMembers < ActiveRecord::Migration[7.2]
  def change
    create_table :account_members do |t|
      t.string :uuid, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
