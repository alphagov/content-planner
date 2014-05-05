class AddApiIdToOrganisations < ActiveRecord::Migration
  def change
    add_column :organisations, :api_id, :string
  end
end
