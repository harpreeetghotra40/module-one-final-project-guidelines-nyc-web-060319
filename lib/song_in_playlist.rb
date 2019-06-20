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
    if required_playlist == nil
      puts "----------------------------------------"
      puts "The playlist does not exist. Try again"
      puts "----------------------------------------"
      edit_playlist
    end
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
    puts "----------------------------------"
    Genre.print_all
    puts "What genre do you like?"
    required_genre = gets.chomp
    required_genre = Genre.find_by(name: required_genre)
    if required_genre == nil
      puts "----------Invalid Input. Try again------------"
      add_songs_to_playlist(playlist)
    end
    Song.print_songs_by_genre(required_genre)
    puts "Add a song you don't see? Type: create song"
    input = gets.chomp
    if input == "create song"
      input = Song.add_song
    end
    song_name = Song.find_by(title: input)
    if song_name == nil
      puts "Huh? That song doesn't exists in our database, would you like to create a new song?"
      puts "Yes || No"
      input = gets.chomp.downcase
      if input == "yes"
        song_name = Song.add_song
      else
        add_songs_to_playlist(playlist)
      end
    end
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
    Song_In_Playlist.all.each do |song|
      if song.playlist_id == Playlist.find_by(name: playlist.name).id
        puts "." + Song.find_by(id: song.song_id).title
      end
    end
    if Playlist.find_by(name: playlist.name).all.length == 0
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
