class Genre < ActiveRecord::Base
  has_many :songs

  def self.add_genre(name)
   Genre.find_or_create_by(name: name)
  end

  def self.print_all
    Genre.all.each do |genre|
      puts ". #{genre.name}"
    end
  end

  def self.update_genre(name, newName)
    update = Genre.find_by(name: name)
    update.name = newName
  end

end
