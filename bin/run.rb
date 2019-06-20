require_relative "../config/environment"
require "json"
require "rest-client"
require_relative "../lib/playlist.rb"
ActiveRecord::Base.logger = nil

def welcome_message
  puts "----------------------------------------------------------------"
  puts "Welcome to our app. Please select from the options below ..."
end

def welcome
  puts "----------------------------------------------------------------"
  prompt = TTY::Prompt.new
  input = prompt.select("") do |menu_items|
    menu_items.choice "1. Create a new playlist", "create"
    menu_items.choice "2. View a playlist", "view"
    menu_items.choice "3. Edit a existing playlist", "edit"
    menu_items.choice "4. Delete a existing playlist", "delete"
    menu_items.choice "5. Exit program", "exit"
  end
  if input == "create"
    Playlist.create_playlist
  elsif input == "view"
    Playlist.view_playlists
  elsif input == "edit"
    Song_In_Playlist.edit_playlist
  elsif input == "delete"
    Playlist.delete_playlist
  elsif input == "exit"
    exit(0)
  else
    welcome
  end
end

puts "\n"
welcome_message
welcome
