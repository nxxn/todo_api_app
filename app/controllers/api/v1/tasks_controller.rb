class Api::V1::TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  def index
    @tasks = Task.all

    render json: @tasks, status: :ok
  end

  # POST /tasks
  def create
    @task = Task.create(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors }, status: :unprocessable_entity
    end
  end

  # GET /tasks/:id
  def show
    render json: @task, status: :ok
  end

  # PUT /tasks/:id
  def update
    if task_params[:tags]
      @task.tag_list(task_params[:tags])
    end

    if @task.update_attributes(task_params.except(:tags))
      render json: @task, status: :ok
    else
      render_error(@task, :unprocessable_entity)
    end
  end

  # DELETE /tasks/:id
  def destroy
    @task.destroy
    head :no_content
  end

  private

  def task_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:title, :done, :tags])
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
