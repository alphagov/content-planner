class AddDueDateToContentPlan < ActiveRecord::Migration
  def change
    add_column :content_plans, :due_quarter, :integer
    add_column :content_plans, :due_year, :integer
  end
end
