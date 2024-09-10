# frozen_string_literal: true

class TaskListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_list, except: %i[index new create]
  before_action only: [ :edit, :update, :destroy ], if: -> { @task_list.inbox? } do
    if request.format.json?
      render_json_with_error(status: :forbidden, message: "Inbox cannot be updated or deleted")
    else
      redirect_to task_lists_url, alert: "You cannot edit or delete the inbox."
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    raise exception unless request.format.json?

    render_json_with_error(status: :not_found, message: "Task list not found")
  end

  def index
    @task_lists = Current.task_lists
  end

  def show
  end

  def new
    @task_list = Current.task_lists.new
  end

  def edit
  end

  def create
    @task_list = Current.task_lists.new(task_list_params)

    respond_to do |format|
      if @task_list.save
        format.html { redirect_to task_list_url(@task_list), notice: "Task list was successfully created." }
        format.json { render :show, status: :created, location: @task_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render_json_with_model_errors(@task_list) }
      end
    end
  end

  def update
    respond_to do |format|
      if @task_list.update(task_list_params)
        format.html { redirect_to task_list_url(@task_list), notice: "Task list was successfully updated." }
        format.json { render :show, status: :ok, location: @task_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render_json_with_model_errors(@task_list) }
      end
    end
  end

  def destroy
    @task_list.destroy!

    respond_to do |format|
      format.html do
        self.current_task_list_id = nil if current_task_list_id.to_s == @task_list.id.to_s

        redirect_to task_lists_url, notice: "Task list was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  private

  def set_task_list
    @task_list = Current.task_lists.find(params[:id])
  end

  def task_list_params
    params.require(:task_list).permit(:name, :description)
  end
end
