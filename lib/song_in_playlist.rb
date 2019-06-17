class Song_In_Playlist < ActiveRecord::Base
  belongs_to :playlists
  belongs_to :song
end
