class CreateOrganisationables < ActiveRecord::Migration
  def change
    create_table :organisationables do |t|
      t.string :organisation_id
      t.references :organisationable
      t.string :organisationable_type
      t.timestamps
    end
    add_index :organisationables, [:organisationable_id, :organisationable_type], name: "organisationables"
    add_index :organisationables, :organisation_id
  end
end
