class ContentRenameStates < ActiveRecord::Migration
  def up
    content = Content.where(status: "Drafting Agency")
    content.update_all(status: "Drafting - agency")

    content = Content.where(status: "Drafting GDS")
    content.update_all(status: "Drafting - GDS")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
