class CreateSongsInPlaylists < ActiveRecord::Migration[5.0]
  def change
    create_table :song_in_playlists do |table|
      table.integer :playlist_id
      table.integer :song_id
    end
  end
end
