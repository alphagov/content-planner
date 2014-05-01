class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :title
      t.string :format
      t.string :slug
      t.string :abbreviation
      t.string :govuk_status
      t.string :parent_organisation
      t.string :ancestry
      t.string :web_url
      t.string :logo_formatted_name
      t.string :organisation_brand_colour_class_name
      t.string :organisation_logo_type_class_name
      t.datetime :api_updated_at
      t.datetime :api_closed_at

      t.timestamps
    end

    add_index :organisations, :ancestry
    add_index :organisations, :slug
  end
end
