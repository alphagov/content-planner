class DropSourceFromContentPlan < ActiveRecord::Migration
  def change
    remove_column :content_plans, :sources
    remove_column :content_plans, :slug
  end
end
