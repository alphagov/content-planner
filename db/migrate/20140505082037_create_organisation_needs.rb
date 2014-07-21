class CreateOrganisationNeeds < ActiveRecord::Migration
  def change
    create_table :organisation_needs do |t|
      t.references :organisation, index: true
      t.references :need, index: true

      t.timestamps
    end
  end
end
