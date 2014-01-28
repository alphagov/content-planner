class AddStatusIdToContents < ActiveRecord::Migration
  def up
    add_column :contents, :status_id, :string, default: 'not_started'

    remove_column :contents, :status
  end

  def down
    add_column :contents, :status, :string

    remove_column :contents, :status_id
  end
end
