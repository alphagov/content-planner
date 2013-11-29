class CreateContentNeeds < ActiveRecord::Migration
  def change
    create_table :content_needs do |t|
      t.integer :content_id
      t.integer :need_id
      
      t.index [:content_id, :need_id]
    end
  end
end
