class Song_In_Playlist < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :song

  def self.view_playlist(required_playlist)
    iterator = 1
    puts "\nSongs in the requested playlist are:"
    puts ""
    puts Playlist.find_by(name: required_playlist).description
    Song_In_Playlist.all.each do |song|
      if song.playlist_id == Playlist.find_by(name: required_playlist).id
        puts "#{iterator}." + Song.find_by(id: song.song_id).title
        iterator += 1
      end
    end
    puts "\n"
    welcome
  end

  def self.edit_playlist
    puts "Which playlist would you like to edit?"
    Playlist.print_playlists
    required_playlist = gets.chomp
    required_playlist = Playlist.find_by(name: required_playlist)
    puts "\n"
    puts "How would you like to edit? add||delete  from playlist?"
    input = gets.chomp.downcase
    if input == "add"
      add_songs_to_playlist(required_playlist)
    end
  end

  def self.add_songs_to_playlist(playlist)
    puts "Which song would you like to add?"
    Song.print_all
  end
end
