# frozen_string_literal: true

class AddDescriptionToTaskLists < ActiveRecord::Migration[7.2]
  def change
    add_column :task_lists, :description, :text
  end
end
