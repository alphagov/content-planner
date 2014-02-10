class RemoveUrlModels < ActiveRecord::Migration
  def up
    drop_table :source_url_content_plans
    drop_table :source_urls
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
