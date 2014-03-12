class ContentPlanUser < ActiveRecord::Base
  belongs_to :content_plan
  belongs_to :user
end
