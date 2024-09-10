# frozen_string_literal: true

class CreateTaskLists < ActiveRecord::Migration[7.2]
  def change
    create_table :task_lists do |t|
      t.string :name, null: true
      t.boolean :inbox, null: false, default: false
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end

    add_index :task_lists, :account_id, unique: true, where: "inbox", name: "index_task_lists_inbox"
  end
end
