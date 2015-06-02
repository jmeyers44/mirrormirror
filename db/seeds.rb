# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

artist1 = Artist.create(name: "Sufjan Stevens")
artist1.albums.create(name: "Carrie and Lowell")
artist1.albums.first.songs.create(name: "The Only Thing")
tag = Tag.create(name: "death")