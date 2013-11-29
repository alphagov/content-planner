class ContentPlanContent < ActiveRecord::Base
  belongs_to :content_plan
  belongs_to :content
end
