class ChangeStates < ActiveRecord::Migration
  def up
    content = Content.specialist.where(status: "Drafting")
    content.update_all(status: "Drafting Agency")

    content = Content.mainstream.where(status: "Drafting")
    content.update_all(status: "Drafting GDS")

    content = Content.specialist.where(status: "2i")
    content.update_all(status: "Specialist 2i")
    
    content = Content.mainstream.where(status: "GDS 2i")
    content.update_all(status: "Mainstream 2i")

    content = Content.mainstream.where(status: "Factcheck")
    content.update_all(status: "Mainstream factcheck")

    content = Content.mainstream.where(status: "Amends")
    content.update_all(status: "Mainstream amends")

    content = Content.specialist.where(status: "Amends")
    content.update_all(status: "Specialist amends")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
