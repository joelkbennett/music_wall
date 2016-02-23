class RenameSongIdToTrackIdInVotes < ActiveRecord::Migration
  def change
    rename_column :votes, :song_id, :track_id
  end
end
