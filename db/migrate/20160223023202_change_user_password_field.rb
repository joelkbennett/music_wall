class ChangeUserPasswordField < ActiveRecord::Migration
  def change
    rename_column :users, :pw_hash, :password_digest
  end
end
