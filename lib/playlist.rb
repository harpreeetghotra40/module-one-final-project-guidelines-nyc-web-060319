class Playlist < ActiveRecord::Base
  has_many :songs, through: :song_in_playlists
end
