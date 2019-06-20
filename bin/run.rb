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
  puts "\n"
  puts "|Create||View||Edit||Delete|-------- |exit|"
  puts "\n"
  input = gets.chomp.downcase
  if input == "create"
    Playlist.create_playlist
  elsif input == "view"
    Playlist.view_playlists
  elsif input == "edit"
    Song_In_Playlist.edit_playlist
  elsif input == "delete"
    Playlist.delete_playlist
  elsif input == 'exit'
      exit(0)
  else
    welcome
  end
end

puts "\n"
welcome_message
welcome
