require_relative "../config/environment"
require "json"
require "rest-client"
require_relative "../lib/playlist.rb"
ActiveRecord::Base.logger = nil

def welcome_message
  puts "----------------------------------------------------------------"
  puts "Welcome to our app. You can view either playlists or create one."
end

def welcome
  puts "----------------------------------------------------------------"
  puts "Create||View||Edit"
  puts "\n"
  input = gets.chomp.downcase
  if input == "create"
    Playlist.create_playlist
  elsif input == "view"
    Playlist.view_playlists
  elsif input == "edit"
    Song_In_Playlist.edit_playlist
  else
    welcome
  end
end

puts "\n"
welcome_message
welcome
