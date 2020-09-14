# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

Pokedex.destroy_all

baseUrl = 'https://pokeapi.co/api/v2/pokemon/'
ids = (1..151).to_a

puts 'starting seeding...'

ids.each do |id|
  url = baseUrl + id.to_s
  # puts url
  json = JSON.parse(open(url).read)
  Pokedex.new(species: json["name"])
  puts "seeded #{json['name']}"
end

puts 'completed seeding!'

