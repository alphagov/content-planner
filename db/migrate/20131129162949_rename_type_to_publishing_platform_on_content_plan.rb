class RenameTypeToPublishingPlatformOnContentPlan < ActiveRecord::Migration
  def change
  	rename_column :content_plans, :type, :platform
  end
end
