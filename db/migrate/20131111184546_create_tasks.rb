class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.boolean :done
      t.references :content_plan

      t.timestamps
    end
  end
end
