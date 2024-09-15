# frozen_string_literal: true

class Web::Task::Items::IncompleteController < Web::Task::Items::BaseController
  before_action :authenticate_user!
  before_action :require_task_list!
  before_action :set_task_item

  def update
    @task_item.incomplete!

    redirect_to(next_location, notice: "Task item was successfully marked as incomplete.")
  end
end
