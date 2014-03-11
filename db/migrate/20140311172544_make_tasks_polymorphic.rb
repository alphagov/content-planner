class MakeTasksPolymorphic < ActiveRecord::Migration
  def up
    change_table :tasks do |t|
      t.rename :content_plan_id, :taskable_id
      t.change :taskable_id, :integer, null: false
      t.string :taskable_type, null: false
    end

    add_index :tasks, [:taskable_id, :taskable_type]

    Task.update_all taskable_type: "ContentPlan" # all current tasks belong to ContentPlans
  end

  def down
    remove_index :tasks, [:taskable_id, :taskable_type]

    change_table :tasks do |t|
      t.rename :taskable_id, :content_plan_id
      t.change :content_plan_id, :integer, null: true
      t.remove :taskable_type
    end
  end
end
