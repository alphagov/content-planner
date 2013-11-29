class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.text :url
      t.string :content_type
      t.string :status

      t.timestamps
    end

    remove_column :content_plans, :content_type
  end
end
