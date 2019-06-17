class CreatePlaylists < ActiveRecord::Migration[5.0]
  def change
    create_table :playlist do |table|
      table.string :name
      table.string :description
    end
  end
end
