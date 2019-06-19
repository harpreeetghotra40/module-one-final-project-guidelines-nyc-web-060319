class Playlist < ActiveRecord::Base
  has_many :songs, through: :song_in_playlists

  def self.create_playlist
    puts "Enter the name of your Playlist"
    playlist_name = gets.chomp
    puts "Enter playlist description for #{playlist_name}"
    playlist_desc = gets.chomp
    if Playlist.find_by(name: playlist_name) == nil
      new_playlist = Playlist.create(name: playlist_name, description: playlist_desc)
      puts "Would you like to add songs to #{new_playlist.name} | Yes | | No |"
      input = gets.chomp.downcase
      if input == 'yes'
        Song_In_Playlist.add_songs_to_playlist(new_playlist)
      else
        welcome
      end
    end
    print_playlists
    welcome
  end

  def self.delete_playlist
    puts "Enter the name of the playlist you want to delete."
    input = gets.chomp
    if Playlist.find_by(name: input) == nil
      puts "-------------Invalid input. Try Again"
      welcome
    else
      required_playlist = Playlist.find_by(name: input)
      Playlist.delete(required_playlist.id)
      puts "The playlist was successfully deleted"
      welcome
    end

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
