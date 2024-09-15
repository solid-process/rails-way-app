# frozen_string_literal: true

class API::V1::Task::ListsController < API::V1::BaseController
  before_action :authenticate_user!
  before_action :set_task_list, except: %i[index create]
  before_action only: [ :update, :destroy ], if: -> { @task_list.inbox? } do
    render_json_with_error(status: :forbidden, message: "Inbox cannot be updated or deleted")
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_json_with_error(status: :not_found, message: "Task list not found")
  end

  def index
    @task_lists = Current.task_lists
  end

  def show
  end

  def create
    @task_list = Current.task_lists.new(task_list_params)

    if @task_list.save
      render :show, status: :created, location: api_v1_task_list_url(@task_list)
    else
      render_json_with_model_errors(@task_list)
    end
  end

  def update
    if @task_list.update(task_list_params)
      render :show, status: :ok, location: api_v1_task_list_url(@task_list)
    else
      render_json_with_model_errors(@task_list)
    end
  end

  def destroy
    @task_list.destroy!

    head :no_content
  end

  private

  def set_task_list
    @task_list = Current.task_lists.find(params[:id])
  end

  def task_list_params
    params.require(:task_list).permit(:name, :description)
  end
end
