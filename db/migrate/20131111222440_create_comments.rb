class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.references :content_plan
      t.text :message

      t.timestamps
    end
  end
end
