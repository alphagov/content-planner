class ContentPlanNeed < ActiveRecord::Base
  belongs_to :content_plan
  belongs_to :need
end
