class ContentsController < ApplicationController
  expose(:content, attributes: :content_params)
  expose(:contents) {
    ContentSearch.new(params[:search]).results.page(params[:page])
  }
  expose(:comment) {
    current_user.comments.build(commentable: content)
  }

  before_filter :authorize_user

  def index
    @search = ContentSearch.new(params[:search])
  end

  def new
    content.content_plans << ContentPlan.find(params[:content_plan_id]) if params[:content_plan_id]
  end

  def create
    if content.save
      if params[:content][:maslow_need_ids].present?
        ContentNeed.where(content_id: content.id).destroy_all
        need_ids = params[:content][:maslow_need_ids].split(",")
        need_ids.each do |nid|
          ContentNeed.find_or_create_by!(content_id: content.id, need_id: nid)
        end
      end
      redirect_to content_path(content), notice: 'Content was successfully created.'
    else
      render :new
    end
  end

  def update
    if content.save
      if params[:content][:maslow_need_ids].present?
        ContentNeed.where(content_id: content.id).destroy_all
        need_ids = params[:content][:maslow_need_ids].split(",")
        need_ids.each do |nid|
          ContentNeed.find_or_create_by!(content_id: content.id, need_id: nid)
        end
      end
      redirect_to content_path(content)
    else
      render :edit
    end
  end

  def destroy
    content.destroy
    redirect_to contents_path
  end

  def content_params
    if current_user.gds_editor?
      params.require(:content)
            .permit(
        :title,
        :description,
        :url,
        :status_id,
        :size,
        :content_type,
        :platform,
        :tag_list,
        :maslow_need_ids,
        user_ids: [],
        content_plan_ids: []
      )

    else
      params.require(:content)
            .permit(
        :title,
        :description,
        :url,
        :status_id,
        :size,
        :content_type,
        :tag_list,
        :maslow_need_ids,
        user_ids: [],
        content_plan_ids: []
      )
    end
  end

  def authorize_user
    authorize content
  end
end
