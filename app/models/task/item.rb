# frozen_string_literal: true

class Task::Item < ApplicationRecord
  self.table_name = "task_items"

  belongs_to :list, foreign_key: "task_list_id"

  scope :completed, -> { where.not(completed_at: nil) }
  scope :incomplete, -> { where(completed_at: nil) }

  validates :name, presence: true

  attribute :completed, :boolean

  normalizes(:name, with: -> { _1.strip })
  normalizes(:description, with: -> { _1.strip })

  before_validation do
    self.completed_at = completed ? Time.current : nil
  end

  after_initialize do
    self.completed = completed?
  end

  def completed?
    completed_at.present?
  end

  def incomplete?
    !completed?
  end

  def complete!
    self.completed = true

    save!
  end

  def incomplete!
    self.completed = false

    save!
  end
end