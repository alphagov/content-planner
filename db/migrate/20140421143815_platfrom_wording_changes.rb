class PlatfromWordingChanges < ActiveRecord::Migration
  def up
    content = Content.specialist.where(status: "Specialist 2i")
    content.update_all(status: "Publisher 2i")

    content = Content.specialist.where(status: "Specialist amends")
    content.update_all(status: "Publisher amends")

    content = Content.mainstream.where(status: "Mainstream 2i")
    content.update_all(status: "Whitehall 2i")

    content = Content.mainstream.where(status: "Mainstream factcheck")
    content.update_all(status: "Whitehall factcheck")

    content = Content.mainstream.where(status: "Mainstream amends")
    content.update_all(status: "Whitehall amends")

    Content.specialist.update_all(platform: "Publisher")
    Content.mainstream.update_all(platform: "Whitehall")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
