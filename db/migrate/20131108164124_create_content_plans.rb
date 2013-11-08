class CreateContentPlans < ActiveRecord::Migration
  def change
    create_table :content_plans do |t|
      t.string :type
      t.integer :size
      t.string :status
      t.string :ref_no
      t.string :title
      t.text :details
      t.string :slug
      t.text :content_type
      t.text :sources
      t.text :handover_detailed_guidance
      t.text :notes

      t.timestamps
    end
  end
end
