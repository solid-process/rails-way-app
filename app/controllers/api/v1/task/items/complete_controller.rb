# frozen_string_literal: true

class API::V1::Task::Items::CompleteController < API::V1::Task::Items::BaseController
  before_action :authenticate_user!
  before_action :require_task_list!
  before_action :set_task_item

  def update
    @task_item.complete!

    render "api/v1/task/items/show", status: :ok, location: task_item_url(@task_item)
  end
end
