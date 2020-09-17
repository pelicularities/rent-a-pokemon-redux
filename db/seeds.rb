# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

# Pokedex

Pokedex.destroy_all
User.destroy_all
Pokemon.destroy_all
Rental.destroy_all

baseUrl = 'https://pokeapi.co/api/v2/pokemon/'
ids = [1, 4, 7, 25, 133].to_a

puts 'starting Pokedex seeding...'

ids.each do |id|
  url = baseUrl + id.to_s
  # puts url
  json = JSON.parse(open(url).read)
  pokedex = Pokedex.create!(species: json["name"].capitalize)
  puts "seeded #{json['name'].capitalize}"
  # upload artwork
 artwork_link = json['sprites']['other']['official-artwork']['front_default']
 if !artwork_link
  artwork_link = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/133.png"
 end
  artwork_png = URI.open(artwork_link)
  pokedex.artwork.attach(io: artwork_png, filename: "#{json['name']}.png", content_type: 'image/png')
end

puts 'completed Pokedex seeding!'

# Users - 4
users = [
  {
    username: 'grace',
    email: 'grace@grace.com',
    password: 'grace123'
  },
  {
    username: 'zack',
    email: 'zack@zack.com',
    password: 'zack123'
  },
  {
    username: 'stephen',
    email: 'stephen@stephen.com',
    password: 'stephen123'
  },
  {
    username: 'allen',
    email: 'allen@allen.com',
    password: 'allen123'
  }
]

users.each do |user|
  User.create!(user)
end

# Pokemon - 5
pokemons = [
  {
    name: 'Pikachu',
    description: 'A yellow Pokemon',
    price: 1000,
    location: 'Pallet Town',
    pokedex: Pokedex.find_by(species: 'Pikachu'),
    user: User.find_by(username: 'grace')
  },
  {
    name: 'Eevee',
    description: 'An evolving Pokemon',
    price: 1100,
    location: 'Pallet Town',
    pokedex: Pokedex.find_by(species: 'Eevee'),
    user: User.find_by(username: 'grace')
  },
  {
    name: 'Bulbasaur',
    description: 'A grass Pokemon',
    price: 1200,
    location: 'Celadon City',
    pokedex: Pokedex.find_by(species: 'Bulbasaur'),
    user: User.find_by(username: 'grace')
  },
  {
    name: 'Charmander',
    description: 'A fire Pokemon',
    price: 1000,
    location: 'Cinnabar Island',
    pokedex: Pokedex.find_by(species: 'Charmander'),
    user: User.find_by(username: 'stephen')
  },
  {
    name: 'Squirtle',
    description: 'A water Pokemon',
    price: 1500,
    location: 'Cerulean City',
    pokedex: Pokedex.find_by(species: 'Squirtle'),
    user: User.find_by(username: 'allen')
  }
]

pokemons.each do |pokemon|
  Pokemon.create!(pokemon)
end


# Rentals - 2
rentals = [
  {
    start_date: "Thu, 01 Jun 2020",
    end_date: "Wed, 14 Jun 2020",
    price: 1000,
    pokemon: Pokemon.find_by(name: 'Squirtle'),
    user: User.find_by(username: 'zack')
  },
  {
    start_date: "Thu, 01 Jun 2020",
    end_date: "Wed, 14 Jun 2020",
    price: 1000,
    pokemon: Pokemon.find_by(name: 'Pikachu'),
    user: User.find_by(username: 'zack')
  }
]

rentals.each do |rental|
  Rental.create!(rental)
end

# Reviews - 2 
