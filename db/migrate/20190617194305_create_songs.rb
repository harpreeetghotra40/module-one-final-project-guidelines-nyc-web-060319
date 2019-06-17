class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |table|
      table.string :title
      table.integer :artist_id
      table.integer :genre_id
    end
  end
end
