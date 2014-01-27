class MakeCommentRelationshipPolymorphic < ActiveRecord::Migration
  def up
    change_table :comments do |t|
      t.rename :content_plan_id, :commentable_id
      t.change :commentable_id, :integer, null: false
      t.string :commentable_type, null: false
    end

    add_index :comments, [:commentable_id, :commentable_type] # queries are going to be based on these two fields

    Comment.update_all commentable_type: "ContentPlan"        # all current comments belong to ContentPlans
  end
  def down
    remove_index :comments, [:commentable_id, :commentable_type]

    change_table :comments do |t|
      t.rename :commentable_id, :content_plan_id
      t.change :content_plan_id, :integer, null: true
      t.remove :commentable_type
    end
  end
end
