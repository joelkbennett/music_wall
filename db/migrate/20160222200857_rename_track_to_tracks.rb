class RenameTrackToTracks < ActiveRecord::Migration
  def change
    rename_table :track, :tracks
  end
end
