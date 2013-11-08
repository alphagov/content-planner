class TagsController < ApplicationController
  def index
    page = params[:page] || 1
    if params[:q].present?
      @tags = ActsAsTaggableOn::Tag.named_like(params[:q]).page(page).per(25)
    else
      @tags = ActsAsTaggableOn::Tag.page(page).per(25)
    end

    respond_to do |format|
      format.html
      format.json {
        render json: @tags.map { |t| { id: t.name, text: t.name } }
      }
    end
  end

  def new
    @tag = ActsAsTaggableOn::Tag.new
  end

  def create
    ActsAsTaggableOn::Tag.find_or_create_with_like_by_name(params[:tag][:name])
    redirect_to tags_path
  end

  def destroy
    ActsAsTaggableOn::Tag.destroy(params[:id])
    redirect_to tags_path
  end
end
