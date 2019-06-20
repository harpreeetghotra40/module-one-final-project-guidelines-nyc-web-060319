# songs have a title then artist and then genre
1000.times do
  a1 = Artist.find_or_create_by(name: Faker::Music.band)
  g1 = Genre.find_or_create_by(name: Faker::Music.genre)
  Song.find_or_create_by(title: Faker::Music.album, artist: a1, genre: g1)
end
