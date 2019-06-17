class CreateSongsInPlaylists < ActiveRecord::Migration[5.0]
  def change
    create_table :song_in_playlists do |table|
      table.text :playlist_id
      table.text :song_id
    end
  end
end
