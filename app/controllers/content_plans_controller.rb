class ContentPlansController < ApplicationController
  expose(:content_plan, attributes: :content_plan_params)
  expose(:content_plans) {
    if params[:tag].present?
      ContentPlan.tagged_with(params[:tag]).page(params[:page])
    else
      ContentPlan.page(params[:page])
    end
  }
  expose(:comment) {
    current_user.comments.build(content_plan: content_plan)
  }

  def create
    if content_plan.save
      if params[:content_plan][:maslow_need_ids].present?
        ContentPlanNeed.where(content_plan_id: content_plan.id).destroy_all
        need_ids = params[:content_plan][:maslow_need_ids].split(",")
        need_ids.each do |nid|
          ContentPlanNeed.find_or_create_by!(content_plan_id: content_plan.id, need_id: nid)
        end
      end
      redirect_to content_plans_path, notice: 'Content plan was successfully created.'
    else
      render :new
    end
  end

  def versions
  end

  def update
    if content_plan.save
      if params[:content_plan][:maslow_need_ids].present?
        ContentPlanNeed.where(content_plan_id: content_plan.id).destroy_all
        need_ids = params[:content_plan][:maslow_need_ids].split(",")
        need_ids.each do |nid|
          ContentPlanNeed.find_or_create_by!(content_plan_id: content_plan.id, need_id: nid)
        end
      end
      redirect_to content_plans_path
    else
      render :edit
    end
  end

  def destroy
    content_plan.destroy
    redirect_to content_plans_path
  end

  def content_plan_params
    params.require(:content_plan).permit(:tag_list,
      :type,
      :size,
      :status,
      :ref_no,
      :title,
      :details,
      :slug,
      :content_type,
      :sources,
      :handover_detailed_guidance,
      :notes,
      :maslow_need_ids
    )
  end
end
