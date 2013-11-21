class TagsController < ApplicationController

  skip_before_filter :authenticate_user!, only: :index
  skip_filter :require_signin_permission!, only: :index

  def index
    page = params[:page] || 1
    if params[:q].present?
      @tags = ActsAsTaggableOn::Tag.named_like(params[:q]).page(page).per(25)
    else
      @tags = ActsAsTaggableOn::Tag.page(page).per(25)
    end

    respond_to do |format|
      format.html { authenticate_user! }
      format.json {
        render json: @tags.map { |t| { id: t.name, text: t.name } }
      }
    end
  end

  def new
    @tag = ActsAsTaggableOn::Tag.new
  end

  def create
    name = params[:tag][:name]
    if name.present?
      downcase_name = name.strip.mb_chars.downcase.to_s
      ActsAsTaggableOn::Tag.find_or_create_with_like_by_name(downcase_name)
    end
    redirect_to tags_path
  end

  def destroy
    ActsAsTaggableOn::Tag.destroy(params[:id])
    redirect_to tags_path
  end
end
