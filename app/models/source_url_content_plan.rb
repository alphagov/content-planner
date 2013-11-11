class SourceUrlContentPlan < ActiveRecord::Base
  belongs_to :source_url
  belongs_to :content_plan
end