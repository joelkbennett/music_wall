class AddRatingToReviews < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.integer :rating
    end
  end
end
