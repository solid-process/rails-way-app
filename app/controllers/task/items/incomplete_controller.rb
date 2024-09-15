# frozen_string_literal: true

class Task::Items::IncompleteController < Task::Items::BaseController
  before_action :authenticate_user!
  before_action :require_task_list!
  before_action :set_task_item

  def update
    @task_item.incomplete!

    respond_to do |format|
      format.html do
        redirect_to(next_location, notice: "Task item was successfully marked as incomplete.")
      end
      format.json { render "task/items/show", status: :ok, location: task_item_url(@task_item) }
    end
  end
end
