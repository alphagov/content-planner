class AddDoneAtToTask < ActiveRecord::Migration
  def up
    add_column :tasks, :done_at, :datetime
    add_index :tasks, :done_at
    add_index :tasks, :done

    # set a `done_at` for completed tasks
    Task.reset_column_information
    Task.completed.update_all(done_at: Time.now)
  end

  def down
    remove_column :tasks, :done_at
    remove_index :tasks, :done_at
    remove_index :tasks, :done
  end
end
