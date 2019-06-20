class Playlist < ActiveRecord::Base
  has_many :songs, through: :song_in_playlists

  def self.create_playlist
    puts "\n"
    puts "\n"
    puts "Enter the name of your Playlist:"
    puts "---------------------------------"
    playlist_name = gets.chomp
    puts "\n"
    puts "Enter playlist description for #{playlist_name}:"
    puts "--------------------------------------"
    playlist_desc = gets.chomp
    if Playlist.find_by(name: playlist_name) == nil
      new_playlist = Playlist.create(name: playlist_name, description: playlist_desc)
      prompt = TTY::Prompt.new
      input = prompt.select("Would you like to add songs to #{new_playlist.name}") do |menu_items|
        menu_items.choice "1. Yes", "yes"
        menu_items.choice "2. No", "no"
      end
      if input == "yes"
        Song_In_Playlist.add_songs_to_playlist(new_playlist)
        puts "----------------------------------------------------"
      else
        welcome
      end
    end
    print_playlists
    welcome
  end

  def self.delete_playlist
    prompt = TTY::Prompt.new
    input = prompt.select("Select the playlist you want to delete.") do |menu_items|
      Playlist.all.each_with_index do |menu_item, index|
        menu_items.choice "#{index + 1}. #{menu_item.name}", menu_item.name
      end
    end
    if Playlist.find_by(name: input) == nil
      puts "-----Invalid input. Try Again--------"
      welcome
    else
      required_playlist = Playlist.find_by(name: input)
      Playlist.delete(required_playlist.id)
      puts "-------------------------------------"
      puts "The playlist was successfully deleted"
      puts "-------------------------------------"
      welcome
    end
  end

  def self.view_playlists
    prompt = TTY::Prompt.new
    required_playlist = prompt.select("Which playlist would you like to view?\n") do |menu_items|
      Playlist.all.each_with_index do |menu_item, index|
        menu_items.choice "#{index + 1}. #{menu_item.name}", menu_item.name
      end
    end
    Song_In_Playlist.view_playlist(required_playlist)
  end

  def self.print_playlists
    Playlist.all.each_with_index do |playlist, index|
      puts "#{index + 1} #{playlist.name}"
    end
  end
end
