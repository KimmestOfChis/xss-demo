class UpdateUserTable < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :password_hash, :password_digest
  end
end
