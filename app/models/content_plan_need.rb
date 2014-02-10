class ContentPlanNeed < ActiveRecord::Base
  belongs_to :content_plan

  def need
    Need.find(need_id)
  end
end
