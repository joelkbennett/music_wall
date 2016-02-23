class EditUserPw < ActiveRecord::Migration
  def change
    remove_column :users, :salt
    remove_column :users, :password

    change_table :users do |t|
      t.string :pw_hash
    end
  end
end
