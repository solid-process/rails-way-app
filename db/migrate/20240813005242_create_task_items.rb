# frozen_string_literal: true

class CreateTaskItems < ActiveRecord::Migration[7.2]
  def change
    create_table :task_items do |t|
      t.string :name, null: false
      t.text :description
      t.datetime :completed_at, index: true
      t.references :task_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
