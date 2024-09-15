# frozen_string_literal: true

class Web::Task::ItemsController < Web::Task::Items::BaseController
  before_action :authenticate_user!
  before_action :require_task_list!
  before_action :set_task_item, except: %i[index new create]

  def index
    @task_items = Current.task_items.filter_by(params[:filter])
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

    if @task_item.save
      redirect_to(next_location, notice: "Task item was successfully created.")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task_item.update(task_item_params)
      redirect_to(next_location, notice: "Task item was successfully updated.")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task_item.destroy!

    redirect_to(next_location, notice: "Task item was successfully destroyed.")
  end

  def complete
    @task_item.complete!

    redirect_to(next_location, notice: "Task item was successfully marked as completed.")
  end

  private

  def task_item_params
    params.require(:task_item).permit(:name, :description, :completed)
  end
end
