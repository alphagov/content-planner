class CreateSourceUrls < ActiveRecord::Migration
  def change
    create_table :source_urls do |t|
      t.text :from_url
      t.string :state
      t.boolean :transitioned
      t.text :to_url
      t.references :department
      t.references :need
      t.timestamps
    end
  end
end
