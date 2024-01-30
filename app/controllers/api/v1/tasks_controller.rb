# frozen_string_literal: true

class Api::V1::TasksController < Api::V1::ApplicationController
  before_action :set_task, only: %i[show update destroy]

  def index
    @tasks = if Task::STATUSES.include?(params[:status])
               @current_user.tasks.public_send(params[:status])
             else
               @current_user.tasks
             end

    render json: @tasks, each_serializer: TaskSerializer, status: :ok
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      render json: @task, serializer: TaskSerializer, status: :created
    else
      error_response(@task.errors.full_messages.first, :unprocessable_entity)
    end
  end

  def show
    render json: @task, serializer: TaskSerializer, status: :ok
  end

  def update
    if @task.update(task_params)
      render json: @task, serializer: TaskSerializer, status: :ok
    else
      error_response(@task.errors.full_messages.first, :unprocessable_entity)
    end
  end

  def destroy
    if @task.destroy
      success_response(t('success.task_destroyed'), :no_content)
    else
      error_response(@task.errors.full_messages.first, :unprocessable_entity)
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    error_response(t('errors.not_found'), :not_found)
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :project_id)
  end
end
