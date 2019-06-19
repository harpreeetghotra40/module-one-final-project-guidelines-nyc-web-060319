class Song < ActiveRecord::Base
  belongs_to :genre
  belongs_to :artist
  has_many :playlists, through: :song_in_playlist

  def self.print_all
    Song.all.each_with_index do |song|
      puts ". #{song.title}"
    end
  end
  
  def self.add_song
  puts "What is the name of the song you would like to add?"
  song_name = gets.chomp
  puts "What is the name of the artist?"
  artist_name = gets.chomp
  puts "What genre does this belong to?"
  Genre.print_all
  genre_name = gets.chomp
  newSong = Song.create(title: song_name,artist: Artist.add_artist(artist_name),genre: Genre.add_genre(genre_name))
  return newSong
  end

end
