class CreateSourceUrls < ActiveRecord::Migration
  def change
    create_table :source_urls do |t|
      t.text :from_url
      t.boolean :needs_assigned, default: false
      t.boolean :content_plan_assigned, default: false
      t.boolean :archive, default: false
      t.boolean :transitioned, default: false
      t.text :to_url
      t.references :department, index: true

      t.timestamps
      t.index :needs_assigned
      t.index :content_plan_assigned
      t.index :archive
      t.index :transitioned
    end
  end
end
