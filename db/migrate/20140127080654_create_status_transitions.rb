class CreateStatusTransitions < ActiveRecord::Migration
  def change
    create_table :status_transitions do |t|
      t.string     :from_id
      t.string     :to_id
      t.datetime   :occurred_at
      t.references :content

      t.index :content_id
    end
  end
end
