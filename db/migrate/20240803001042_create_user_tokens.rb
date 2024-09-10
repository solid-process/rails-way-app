# frozen_string_literal: true

class CreateUserTokens < ActiveRecord::Migration[7.2]
  def change
    create_table :user_tokens do |t|
      t.string :short, null: false, limit: 8, index: { unique: true }
      t.string :checksum, null: false, limit: 64
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
