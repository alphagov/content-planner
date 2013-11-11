class ContentPlansController < ApplicationController
  expose(:content_plan, attributes: :content_plan_params)
  expose(:content_plans) {
    if params[:tag].present?
      ContentPlan.tagged_with(params[:tag]).page(params[:page])
    else
      ContentPlan.page(params[:page])
    end
  }


  def create
    if content_plan.save
      redirect_to content_plans_path
    else
      render :new
    end
  end

  def update
    if content_plan.save
      redirect_to content_plans_path
    else
      render :edit
    end
  end

  def content_plan_params
    params.require(:content_plan).permit(:tag_list, :type, :size, :status, :ref_no, :title, :details, :slug, :content_type, :sources, :handover_detailed_guidance, :notes)
  end
end
