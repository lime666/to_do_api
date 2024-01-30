# frozen_string_literal: true

class Api::V1::ProjectsController < Api::V1::ApplicationController
  before_action :set_project, only: %i[show update destroy]

  def index
    @projects = @current_user.projects
    render json: @projects, each_serializer: ProjectSerializer, status: :ok
  end

  def create
    @project = @current_user.projects.new(project_params)
    if @project.save
      render json: @project, serializer: ProjectSerializer, status: :created
    else
      error_response(@project.errors.full_messages.first, :bad_request)
    end
  end

  def show
    render json: @project, serializer: ProjectSerializer, status: :ok
  end

  def update
    if @project.update(project_params)
      render json: @project, serializer: ProjectSerializer, status: :ok
    else
      error_response(@project.errors.full_messages.first, :bad_request)
    end
  end

  def destroy
    if @project.destroy
      success_response(t('success.project_destroyed'), :no_content)
    else
      error_response(@project.errors.full_messages.first, :bad_request)
    end
  end

  def index_projects_with_tasks
    @projects = @current_user.projects.includes(:tasks)

    cache_key = "projects_with_tasks/#{current_user.id}-#{Project.maximum(:updated_at)}"

    cached_data = Rails.cache.fetch(cache_key) do
      @projects.as_json(include: :tasks)
    end

    render json: cached_data
  end

  private

  def set_project
    @project = @current_user.projects.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    error_response(t('errors.not_found'), :not_found)
  end

  def project_params
    params.permit(:title, :description, :user_id)
  end
end
