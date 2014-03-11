class ContentPlansController < ApplicationController
  expose_decorated(:content_plan, attributes: :content_plan_params)
  expose_decorated(:content_plans) {
    ContentPlanSearch.new(params[:search]).results.order(:ref_no).page(params[:page])
  }
  expose(:comment) {
    current_user.comments.build(commentable: content_plan)
  }

  before_filter :authorize_user

  def index
    @search = ContentPlanSearch.new(params[:search])
    respond_to do |format|
      format.html
      format.json {
        render json: content_plans.map { |cp| { id: cp.id, text: cp.name } }
      }
    end
  end

  def create
    if content_plan.save
      redirect_to content_plans_path, notice: "Content plan was successfully created."
    else
      render :new
    end
  end

  def versions
  end

  def update
    if content_plan.save
      redirect_to content_plan_path content_plan
    else
      render :edit
    end
  end

  def destroy
    content_plan.destroy
    redirect_to content_plans_path
  end

  private

  def content_plan_params
    params.require(:content_plan).permit(:tag_list,
                                         :status,
                                         :ref_no,
                                         :title,
                                         :details,
                                         :slug,
                                         :handover_detailed_guidance,
                                         :notes,
                                         :due_quarter,
                                         :due_year,
                                         maslow_need_ids: [],
                                         organisation_ids: []
    )
  end

  def authorize_user
    authorize content_plan
  end
end
