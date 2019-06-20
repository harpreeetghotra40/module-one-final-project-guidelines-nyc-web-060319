class Artist < ActiveRecord::Base
  has_many :songs

  def self.add_artist(name)
    Artist.find_or_create_by(name: name)
  end
end


