class AddContentPlanNeeds < ActiveRecord::Migration
  def change
    create_table :content_plan_needs do |t|
      t.integer :content_plan_id
      t.integer :need_id

      t.index [:content_plan_id, :need_id]
    end
  end
end
