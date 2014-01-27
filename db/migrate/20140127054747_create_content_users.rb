class CreateContentUsers < ActiveRecord::Migration
  def change
    create_table :content_users do |t|
      t.integer :content_id
      t.integer :user_id

      t.index [:content_id, :user_id]
    end
  end
end
