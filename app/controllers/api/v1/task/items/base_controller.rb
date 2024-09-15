# frozen_string_literal: true

class API::V1::Task::Items::BaseController < API::V1::BaseController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_json_with_error(status: :not_found, message: "Task list or item not found")
  end

  private

  def require_task_list!
    raise ActiveRecord::RecordNotFound unless Current.task_list_id
  end

  def set_task_item
    @task_item = Current.task_items.find(params[:id])
  end

  def task_items_url(...)
    api_v1_task_list_items_url(Current.task_list_id, ...)
  end

  def task_item_url(...)
    api_v1_task_list_item_url(Current.task_list_id, ...)
  end
end
