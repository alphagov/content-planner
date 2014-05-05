class CreateNeeds < ActiveRecord::Migration
  def change
    create_table :needs do |t|
      t.integer :api_id
      t.string :role
      t.string :goal
      t.string :benefit
      t.boolean :applies_to_all_organisations, default: false
      t.string :in_scope
    end
  end
end
