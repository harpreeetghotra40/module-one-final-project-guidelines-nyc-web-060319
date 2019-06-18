class Song < ActiveRecord::Base
  belongs_to :genre
  belongs_to :artist
  has_many :playlists, through: :song_in_playlist

  def self.print_all
    index = 0
    Song.all.each_with_index do |song|
      puts "#{index + 1}. #{song.title}"
      index += 1
    end
  end
end
