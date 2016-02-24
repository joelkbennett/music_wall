class AddBodyToTrack < ActiveRecord::Migration
  def change
    change_table :tracks do |t|
      t.text :about
    end
  end
end
