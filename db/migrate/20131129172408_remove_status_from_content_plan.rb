class RemoveStatusFromContentPlan < ActiveRecord::Migration
  def change
    remove_column :content_plans, :status, :string
  end
end
