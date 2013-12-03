class MovePointsToContent < ActiveRecord::Migration
  def change
    remove_column :content_plans, :size, :integer
    add_column :contents, :size, :integer
  end
end
