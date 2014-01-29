class AddIndexesToOrganisationable < ActiveRecord::Migration
  def change
    add_index :organisationables, :organisationable_type
    add_index :organisationables, [:organisationable_type, :organisation_id], name: "organisationable_type"
  end
end
