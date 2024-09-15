# frozen_string_literal: true

class Web::Task::Items::BaseController < Web::BaseController
  private

  def require_task_list!
    raise ActiveRecord::RecordNotFound unless Current.task_list_id
  end

  def set_task_item
    @task_item = Current.task_items.find(params[:id])
  end

  def task_items_url(...)
    task_list_items_url(Current.task_list_id, ...)
  end

  def task_item_url(...)
    task_list_item_url(Current.task_list_id, ...)
  end

  def next_location
    case params[:filter]
    when "completed" then task_items_url(filter: "completed")
    when "incomplete" then task_items_url(filter: "incomplete")
    when "show" then task_item_url(@task_item)
    else task_items_url
    end
  end
end
