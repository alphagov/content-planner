class AddRefToContents < ActiveRecord::Migration
  def change
    add_column :contents, :ref_no, :string
  end
end
