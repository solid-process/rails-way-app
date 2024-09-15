# frozen_string_literal: true

class Web::Task::ListsController < Web::BaseController
  before_action :authenticate_user!
  before_action :set_task_list, except: %i[index new create]
  before_action only: [ :edit, :update, :destroy ], if: -> { @task_list.inbox? } do
    redirect_to task_lists_url, alert: "You cannot edit or delete the inbox."
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

    if @task_list.save
      redirect_to task_list_url(@task_list), notice: "Task list was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task_list.update(task_list_params)
      redirect_to task_list_url(@task_list), notice: "Task list was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task_list.destroy!

    self.current_task_list_id = nil if current_task_list_id.to_s == @task_list.id.to_s

    redirect_to task_lists_url, notice: "Task list was successfully destroyed."
  end

  private

  def set_task_list
    @task_list = Current.task_lists.find(params[:id])
  end

  def task_list_params
    params.require(:task_list).permit(:name, :description)
  end
end
