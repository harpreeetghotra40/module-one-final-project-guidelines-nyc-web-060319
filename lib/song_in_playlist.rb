class Song_In_Playlist < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :song

  def self.view_playlist(required_playlist)
    system "clear"
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
        puts "#{iterator}. #{Song.find_by(id: song.song_id).title}".yellow
        iterator += 1
      end
    end
    puts "\n"
    welcome
  end

  def self.edit_playlist
    prompt = TTY::Prompt.new
    required_playlist = prompt.select("Which playlist would you like to edit?") do |menu_items|
      Playlist.all.each_with_index do |menu_item, index|
        menu_items.choice "#{index + 1}. #{menu_item.name}", menu_item.name
      end
    end
    required_playlist = Playlist.find_by(name: required_playlist)
    if required_playlist == nil
      puts "----------------------------------------"
      puts "The playlist does not exist. Try again"
      puts "----------------------------------------"
      edit_playlist
    end
    puts "\n"
    prompt = TTY::Prompt.new
    input = prompt.select("Which playlist would you like to edit?") do |menu_items|
      menu_items.choice "Add songs to playlist.", "add"
      menu_items.choice "Delete songs from playlist.", "delete"
    end
    if input == "add"
      add_songs_to_playlist(required_playlist)
    elsif input == "delete"
      delete_song_from_playlist(required_playlist)
    end
  end

  def self.add_songs_to_playlist(playlist)
    system "clear"
    puts "----------------------------------"
    prompt = TTY::Prompt.new
    required_genre = prompt.select("What genre do you like?", per_page: 10) do |menu_items|
      Genre.all.each_with_index do |menu_item, index|
        menu_items.choice "#{index + 1}. #{menu_item.name}", menu_item.name
      end
    end
    required_genre = Genre.find_by(name: required_genre)
    if required_genre == nil
      puts "----------Invalid Input. Try again------------"
      add_songs_to_playlist(playlist)
    end

    prompt = TTY::Prompt.new
    input = prompt.select("Here are a few songs from that genre.") do |menu_items|
      Song.all.each do |menu_item|
        if menu_item.genre_id == required_genre.id
          menu_items.choice "#{menu_item.title}", menu_item.title
        end
      end
    end
    puts "Add a song you don't see? Type: create song"
    if input == "create song"
      input = Song.add_song
    end
    song_name = Song.find_by(title: input)
    if song_name == nil
      puts "Huh? That song doesn't exists in our database, would you like to create a new song?"
      prompt = TTY::Prompt.new
      input = prompt.select("Would you like to add another song?") do |menu_items|
        menu_items.choice "Yes", "yes"
        menu_items.choice "No", "no"
      end
      input = gets.chomp.downcase
      if input == "yes"
        song_name = Song.add_song
      else
        add_songs_to_playlist(playlist)
      end
    end
    Song_In_Playlist.find_or_create_by(playlist_id: playlist.id, song_id: song_name.id)
    puts "Your song has been successfully added!"
    puts "---------------------------------------"
    prompt = TTY::Prompt.new
    input = prompt.select("Would you like to add another song?") do |menu_items|
      menu_items.choice "Yes", "yes"
      menu_items.choice "No", "no"
    end
    if input == "yes"
      add_songs_to_playlist(playlist)
    else
      welcome
    end
  end

  def self.delete_song_from_playlist(playlist)
    counter = 0
    prompt = TTY::Prompt.new
    input = prompt.select("Which song would you like to delete?") do |menu_items|
      Song_In_Playlist.all.each do |song|
        if song.playlist_id == Playlist.find_by(name: playlist.name).id
          menu_items.choice Song.find_by(id: song.song_id).title
          counter += 1
        end
      end
    end

    if counter == 0
      puts "The Playlist is empty."
      welcome
    end

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
