class SourceUrlContentPlans < ActiveRecord::Migration
  def change
    create_table :source_url_content_plans do |t|
      t.belongs_to :source_url
      t.belongs_to :content_plan
    end
  end
end
