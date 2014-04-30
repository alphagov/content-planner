class CreateTaskAndUsers < ActiveRecord::Migration
  def change
    create_table :task_and_users do |t|
      t.references :task, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
