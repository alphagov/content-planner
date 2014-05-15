class ContentsController < ApplicationController
  expose(:content, attributes: :content_params)
  expose(:content_plan) { ContentPlan.find(params[:content_plan_id]) }
  expose(:search) {
    if params[:content_plan_id].present?
      PlanContentsSearch.new(contents_search_params)
    else
      ContentSearch.new(params[:search])
    end
  }
  expose(:contents) {
    search.results.page(params[:page])
  }
  expose(:content_plans) { content.content_plans.order(:ref_no) }
  expose(:comment) {
    current_user.comments.build(commentable: content)
  }
  expose(:comments) {
    content.comments
           .roots
           .includes(:user, :commentable,  children: [:user, :parent, :commentable])
           .page(params[:page])
  }
  expose(:task) {
    Task.new(taskable: content)
  }
  expose(:tasks) {
    content.tasks.includes(:users).by_deadline
  }

  before_filter :authorize_user, except: [:index]

  def index
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
        :publish_by,
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
        :publish_by,
        organisation_ids: [],
        maslow_need_ids: [],
        user_ids: [],
        content_plan_ids: []
      )
    end
  end

  def contents_search_params
    (params[:search] || {}).merge(content_plan_id: params[:content_plan_id])
  end

  def authorize_user
    authorize content
  end
end
