class Song_In_Playlist < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :song

  def self.view_playlist(required_playlist)
    puts "------------------------------------------"
    if Playlist.find_by(name: required_playlist) == nil
      puts "Invaild input, please try again."
      puts ""
      Playlist.view_playlists
    end
    iterator = 1
    puts "\nSongs in the requested playlist are:"
    puts ""
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
    elsif input == "delete"
      delete_song_from_playlist(required_playlist)
    end
  end

  def self.add_songs_to_playlist(playlist)
    puts "Which song would you like to add?"
    Song.print_all
    input = gets.chomp
    song_name = Song.find_by(title: input)
    Song_In_Playlist.find_or_create_by(playlist_id: playlist.id, song_id: song_name.id) 
    puts "Your song has been successfully added!"
    puts "Would you like to add another song? |Yes|No|" 
    input = gets.chomp.downcase
    if input == "yes"
      add_songs_to_playlist(playlist)
    else
      welcome
    end
  end

  def self.delete_song_from_playlist(playlist)
    iterator = 1
    Song_In_Playlist.all.each do |song|
      if song.playlist_id == Playlist.find_by(name: playlist.name).id
        puts "#{iterator}." + Song.find_by(id: song.song_id).title
        iterator += 1
      end
    end
    if iterator == 1
      puts "The Playlist is empty."
      welcome
    end
    puts "Which song would you like to delete?"
    input = gets.chomp
    song_name = Song.find_by(title: input)
    if song_name == nil
      puts "----- Invalid Input. Try Again --------------"
      delete_song_from_playlist(playlist)
    end
    row_name = Song_In_Playlist.find_by(song_id: song_name.id)
    Song_In_Playlist.delete(row_name.id)
    puts "The song was successfully deleted.."
    view_playlist(playlist.name) 
  end
end

