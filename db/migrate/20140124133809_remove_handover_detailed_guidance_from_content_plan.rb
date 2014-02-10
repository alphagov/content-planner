class RemoveHandoverDetailedGuidanceFromContentPlan < ActiveRecord::Migration
  def up
    ContentPlan.find_each do |content_plan|
      content_plan.update details: content_plan.details.to_s + content_plan.handover_detailed_guidance.to_s
    end
    remove_column :content_plans, :handover_detailed_guidance, :text
  end
  
  def down
    add_column :content_plans, :handover_detailed_guidance, :text
  end
end
