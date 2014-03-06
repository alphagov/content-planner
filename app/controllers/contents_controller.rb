class ContentsController < ApplicationController
  expose(:content, attributes: :content_params)
  expose(:contents) {
    ContentSearch.new(params[:search]).results.order(:ref_no).page(params[:page])
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
      redirect_to content_path(content), notice: "Content was successfully created."
    else
      render :new
    end
  end

  def update
    if content.save
      redirect_to content_path(content)
    else
      render :edit
    end
  end

  def destroy
    content.destroy
    redirect_to contents_path
  end

  private

  def content_params
    if current_user.gds_editor?
      params.require(:content)
            .permit(
        :ref_no,
        :title,
        :description,
        :url,
        :status,
        :size,
        :content_type,
        :platform,
        :tag_list,
        organisation_ids: [],
        maslow_need_ids: [],
        user_ids: [],
        content_plan_ids: []
      )

    else
      params.require(:content)
            .permit(
        :ref_no,
        :title,
        :description,
        :url,
        :status,
        :size,
        :content_type,
        :tag_list,
        organisation_ids: [],
        maslow_need_ids: [],
        user_ids: [],
        content_plan_ids: []
      )
    end
  end

  def authorize_user
    authorize content
  end
end
