class ContentPlansController < ApplicationController
  expose(:content_plan, attributes: :content_plan_params)
  expose(:content_plans)

  def source_url_params
    params.require(:content_plan).permit(:type, :size, :status, :ref_no, :title, :details, :slug, :content_type, :sources, :handover_detailed_guidance, :notes)
  end
end
