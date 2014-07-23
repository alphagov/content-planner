class PlatformWordingAmends < ActiveRecord::Migration
  def up
    # things messed up in 20140421143815_platfrom_wording_changes.rb
    # should've been:
    # specialist -> whitehall
    # mainstream -> publisher
    #
    # now:
    # whitehall -> publisher
    # publisher -> whitehall
    whitehall_ids = Content.whitehall.pluck :id
    publisher_ids = Content.publisher.pluck :id
    Content.where(id: whitehall_ids).update_all(platform: "Publisher")
    Content.where(id: publisher_ids).update_all(platform: "Whitehall")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
