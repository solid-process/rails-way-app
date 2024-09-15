# frozen_string_literal: true

class Task::ItemsController < ApplicationController
  include TaskItemsConcern

  before_action :authenticate_user!
  before_action :require_task_list!
  before_action :set_task_item, except: %i[index new create]

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

  private

  def task_item_params
    params.require(:task_item).permit(:name, :description, :completed)
  end
end
