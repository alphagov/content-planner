class AddPublishByToContents < ActiveRecord::Migration
  def change
    add_column :contents, :publish_by, :date
  end
end
