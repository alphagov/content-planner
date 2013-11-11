class ContentPlansController < ApplicationController
  expose(:content_plan, attributes: :content_plan_params)
  expose(:content_plans)

  def create
    if content_plan.save
      redirect_to content_plans_path
    else
      render :new
    end
  end

  def show
  end

  def index
    respond_to do |format|
      format.html
      format.json {
        render json: content_plans.map { |cp| { id: cp.id, text: "#{cp.ref_no} - #{cp.title}" } }
      }
    end
  end

  def content_plan_params
    params.require(:content_plan).permit(:type, :size, :status, :ref_no, :title, :details, :slug, :content_type, :sources, :handover_detailed_guidance, :notes)
  end
end
