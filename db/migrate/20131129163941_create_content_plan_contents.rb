class CreateContentPlanContents < ActiveRecord::Migration
  def change
    create_table :content_plan_contents do |t|
      t.integer :content_plan_id
      t.integer :content_id

      t.timestamps
    end
  end
end
