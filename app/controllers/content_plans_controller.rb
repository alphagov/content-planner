class ContentPlansController < ApplicationController
  helper_method :sort_column, :sort_direction, :content_plan_filter

  expose_decorated(:content_plan, attributes: :content_plan_params)
  expose_decorated(:content_plans) {
    search.results.page(params[:page])
  }
  expose(:search) {
    ContentPlanSearch.new(params[:search])
  }
  expose(:comment) {
    current_user.comments.build(commentable: content_plan)
  }
  expose(:comments) {
    content_plan.comments
                .roots
                .includes(:user, :commentable,  children: [:user, :parent, :commentable])
                .page(params[:page])
  }
  expose(:task) {
    Task.new(taskable: content_plan)
  }
  expose(:tasks) {
    content_plan.tasks.includes(:users).by_deadline
  }
  expose(:contents_search) {
    PlanContentsSearch.new(contents_search_params, sort_column, sort_direction)
  }
  expose(:contents) {
    contents_search.results.page(params[:page])
  }
  expose(:all_contents) {
    content_plan.contents
  }
  expose(:specialist_contents) {
    all_contents.specialist
  }
  expose(:mainstream_contents) {
    all_contents.mainstream
  }
  expose(:content_records_statuses) {
    contents.pluck(:status).uniq
  }
  expose(:all_records_are_live?) {
    content_records_statuses.size == 1 &&
    content_records_statuses[0] == "Live"
  }

  before_filter :authorize_user
  before_action :require_all_records_to_be_live!, only: :xls_export

  def index
    respond_to do |format|
      format.html
      format.json {
        render json: content_plans.map { |cp| { id: cp.id, text: cp.name } }
      }
    end
  end

  def show
    self.content_plan = ContentPlan.includes(:contents, :tasks)
                                   .find(params[:id])
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

  def xls_export
    xls_data, xls_filename = ContentPlans::XlsExport.new(content_plan).run

    send_data(
      xls_data,
      filename: xls_filename,
      type: "application/vnd.ms-excel"
    )
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
                                         user_ids: [],
                                         need_ids: [],
                                         organisation_ids: []
    )
  end

  def contents_search_params
    { content_plan_id: content_plan.id }
  end

  def authorize_user
    authorize content_plan
  end

  def require_all_records_to_be_live!
    unless all_records_are_live?
      redirect_to content_plan,
                  alert: "Excel export available only if all records have been changed to the 'live' status"
    end
  end

  def sort_column
    Content.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def content_plan_filter
    params[:id] || nil
  end
end
