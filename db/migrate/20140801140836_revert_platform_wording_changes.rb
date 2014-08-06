class RevertPlatformWordingChanges < ActiveRecord::Migration
  def up
    # revert 20140421143815_platfrom_wording_changes
    # from Publisher to Specialist
    content = Content.where(status: "Publisher 2i")
    content.update_all(status: "Specialist 2i")

    content = Content.where(status: "Publisher amends")
    content.update_all(status: "Specialist amends")

    # from Whitehall to Mainstream
    content = Content.where(status: "Whitehall 2i")
    content.update_all(status: "Mainstream 2i")

    content = Content.where(status: "Whitehall factcheck")
    content.update_all(status: "Mainstream factcheck")

    content = Content.where(status: "Whitehall amends")
    content.update_all(status: "Mainstream amends")

    # revert 20140723200657_platform_wording_amends
    # Whitehall -> Specialist
    # Publisher -> Mainstream
    whitehall_ids = Content.platform("Whitehall").pluck :id
    publisher_ids = Content.platform("Publisher").pluck :id
    Content.where(id: whitehall_ids).update_all(platform: "Specialist")
    Content.where(id: publisher_ids).update_all(platform: "Mainstream")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
