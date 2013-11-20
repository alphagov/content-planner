class GdsSsoUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
      t.remove :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
      t.string :uid
      t.index :uid
      t.string :organisation_slug
      t.index :organisation_slug
      t.string :permissions
      t.boolean :remotely_signed_out, default: false
    end
  end
end
