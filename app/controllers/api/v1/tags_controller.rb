class Api::V1::TagsController < ApplicationController
  before_action :set_tag, only: [:show, :update, :destroy]

  # GET /tags
  def index
    @tags = Tag.all

    render json: @tags, status: :ok
  end

  # POST /tags
  def create
    @tag = Tag.create!(tag_params)

    if @tag.save
      render json: @tag, status: :created
    else
      render json: { errors: @tag.errors }, status: :unprocessable_entity
    end
  end

  # GET /tags/:id
  def show
    render json: @tag, status: :ok
  end

  # PUT /tags/:id
  def update
    if @tag.update_attributes(tag_params)
      render json: @tag, status: :ok
    else
      render_error(@tag, :unprocessable_entity)
    end
  end

  # DELETE /tags/:id
  def destroy
    @tag.destroy
    head :no_content
  end

  private

  def tag_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:title])
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
