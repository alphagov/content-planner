class ContentStatusesWordingChanges < ActiveRecord::Migration
  def up
    # Drafting - agency -> Drafting
    # Drafting - GDS    -> Drafting
    Content.where(status: "Drafting - agency").update_all(status: "Drafting")
    Content.where(status: "Drafting - GDS").update_all(status: "Drafting")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
