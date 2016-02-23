class AddCommentsTable < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.references :track
      t.text :comment
      t.timestamps
    end
  end
end
