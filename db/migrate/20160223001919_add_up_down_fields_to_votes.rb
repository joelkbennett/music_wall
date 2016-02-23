class AddUpDownFieldsToVotes < ActiveRecord::Migration
  def change
    change_table :votes do |t|
      t.boolean :liked
    end
  end
end
