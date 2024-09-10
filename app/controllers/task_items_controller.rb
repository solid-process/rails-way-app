# frozen_string_literal: true

class TaskItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_task_list!
  before_action :set_task_item, except: %i[index new create]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    raise exception unless request.format.json?

    render_json_with_error(status: :not_found, message: "Task list or item not found")
  end

  def index
    task_items = Current.task_items

    @task_items =
      case params[:filter]
      when "completed" then task_items.completed.order(completed_at: :desc)
      when "incomplete" then task_items.incomplete.order(created_at: :desc)
      else task_items.order(Arel.sql("task_items.completed_at DESC NULLS FIRST, task_items.created_at DESC"))
      end
  end

  def show
  end

  def new
    @task_item = Current.task_items.new
  end

  def edit
  end

  def create
    @task_item = Current.task_items.new(task_item_params)

    respond_to do |format|
      if @task_item.save
        format.html do
          redirect_to(next_location, notice: "Task item was successfully created.")
        end
        format.json do
          render :show, status: :created, location: task_item_url(@task_item)
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render_json_with_model_errors(@task_item) }
      end
    end
  end

  def update
    respond_to do |format|
      if @task_item.update(task_item_params)
        format.html do
          redirect_to(next_location, notice: "Task item was successfully updated.")
        end
        format.json { render :show, status: :ok, location: task_item_url(@task_item) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render_json_with_model_errors(@task_item) }
      end
    end
  end

  def destroy
    @task_item.destroy!

    respond_to do |format|
      format.html do
        redirect_to(next_location, notice: "Task item was successfully destroyed.")
      end
      format.json { head :no_content }
    end
  end

  def complete
    @task_item.complete!

    respond_to do |format|
      format.html do
        redirect_to(next_location, notice: "Task item was successfully marked as completed.")
      end
      format.json { render :show, status: :ok, location: task_item_url(@task_item) }
    end
  end

  def incomplete
    @task_item.incomplete!

    respond_to do |format|
      format.html do
        redirect_to(next_location, notice: "Task item was successfully marked as incomplete.")
      end
      format.json { render :show, status: :ok, location: task_item_url(@task_item) }
    end
  end

  private

  def require_task_list!
    raise ActiveRecord::RecordNotFound unless Current.task_list_id
  end

  def set_task_item
    @task_item = Current.task_items.find(params[:id])
  end

  def task_item_params
    params.require(:task_item).permit(:name, :description, :completed)
  end

  def task_items_url(...)
    task_list_task_items_url(Current.task_list_id, ...)
  end

  def task_item_url(...)
    task_list_task_item_url(Current.task_list_id, ...)
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
