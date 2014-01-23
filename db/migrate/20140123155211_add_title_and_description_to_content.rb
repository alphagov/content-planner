class AddTitleAndDescriptionToContent < ActiveRecord::Migration
  def change
    add_column :contents, :title, :string, null: false
    add_column :contents, :description, :text
  end
end
