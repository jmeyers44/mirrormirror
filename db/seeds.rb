# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user1 = User.find(1)
song1 = Song.create(name: "Song Name")
album1 = Album.create(name: "Album Name")
artist1 = Artist.create(name: "Artist Name")
artist1.albums << album1
album1.songs << song1
user1.songs << song1
