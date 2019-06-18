class Playlist < ActiveRecord::Base
  has_many :songs, through: :song_in_playlists

  def self.create_playlist
    puts "Enter the name of your Playlist"
    playlist_name = gets.chomp
    puts "Enter playlist description for #{playlist_name}"
    playlist_desc = gets.chomp
    new_playlist = Playlist.find_or_create_by(name: playlist_name, description: playlist_desc)
    print_playlists
    welcome
  end

  def self.view_playlists
    Playlist.print_playlists
    puts "Which playlist would you like to view?\n"
    required_playlist = gets.chomp
    Song_In_Playlist.view_playlist(required_playlist)
  end

  def self.print_playlists
    Playlist.all.each_with_index do |playlist, index|
      puts "#{index + 1} #{playlist.name}"
    end
  end
end
