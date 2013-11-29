class MovePlatformToContent < ActiveRecord::Migration
  def change
    remove_column :content_plans, :platform, :string
    add_column :contents, :platform, :string
  end
end
