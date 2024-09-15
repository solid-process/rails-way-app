# frozen_string_literal: true

class Web::Task::Items::CompleteController < Web::Task::Items::BaseController
  before_action :authenticate_user!
  before_action :require_task_list!
  before_action :set_task_item

  def update
    @task_item.complete!

    redirect_to(next_location, notice: "Task item was successfully marked as completed.")
  end
end
