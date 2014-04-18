class ContentPlansController < ApplicationController
  expose_decorated(:content_plan, attributes: :content_plan_params)
  expose_decorated(:content_plans) {
    ContentPlanSearch.new(params[:search]).results.order(:ref_no).page(params[:page])
  }
  expose(:comment) {
    current_user.comments.build(commentable: content_plan)
  }
  expose(:task) {
    Task.new(taskable: content_plan)
  }
  expose(:contents) {
    content_plan.contents
  }
  expose(:content_records_statuses) {
    contents.pluck(:status).uniq
  }
  expose(:all_records_are_live?) {
    content_records_statuses.size == 1 &&
    content_records_statuses[0] == 'Live'
  }

  before_filter :authorize_user
  before_action :require_all_records_to_be_live!, only: :csv_export

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

  def csv_export
    csv_data, csv_filename = ContentPlans::CsvExport.new(content_plan).run

    send_data(
      csv_data.force_encoding(::Encoding::UTF_8),
      filename: csv_filename,
      type: 'text/csv; charset=Unicode(UTF-8); header=present'
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
                                         maslow_need_ids: [],
                                         organisation_ids: []
    )
  end

  def authorize_user
    authorize content_plan
  end

  def require_all_records_to_be_live!
    all_records_are_live?
  end
end
