class AddContentPlanUsers < ActiveRecord::Migration
  def change
    create_table :content_plan_users do |t|
      t.integer :content_plan_id, null: false
      t.integer :user_id, null: false

      t.index [:content_plan_id, :user_id]
    end
  end
end
