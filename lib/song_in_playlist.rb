class Song_In_Playlist < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :song
end
