# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'faker'

# Pokedex
Review.destroy_all
Pokedex.destroy_all
User.destroy_all
Pokemon.destroy_all
Rental.destroy_all

baseUrl = 'https://pokeapi.co/api/v2/pokemon/'
ids = (1..151).to_a

# ids = [1, 2, 3, 150, 151]

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

puts 'seeding users...'

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
  puts "seeded #{user[:username]}"
end

puts "seeded users!"

puts "seeding Pokemon..."

# Pokemon - 12
3.times do
  pokemon = Pokemon.create!(
    name: Faker::Name.unique.first_name,
    description: Faker::Lorem.sentence,
    price: Faker::Number.between(from: 10, to: 120),
    location: Faker::Games::Pokemon.location,
    user: User.find_by_username('grace'),
    pokedex: Pokedex.all.sample
  )
  puts "seeded #{pokemon.name} (#{pokemon.pokedex.species}, #{pokemon.user.username})"
end
9.times do
  pokemon = Pokemon.new(
    name: Faker::Name.unique.first_name,
    description: Faker::Lorem.sentence,
    price: Faker::Number.between(from: 10, to: 120),
    location: Faker::Games::Pokemon.location,
    pokedex: Pokedex.all.sample
  )
  loop do
    pokemon.user = User.all.sample
    break unless pokemon.user == User.find_by_username('grace')
  end
  pokemon.save!
  puts "seeded #{pokemon.name} (#{pokemon.pokedex.species}, #{pokemon.user.username})"
end

puts "seeded Pokemon!"

puts "seeding rentals..."

grace = User.find_by_username('grace')

# Rentals - 12
4.times do
  rental = Rental.new(
    start_date: "2020-06-01",
    end_date: "2020-06-08",
    pokemon: Pokemon.all.sample
  )
  if rental.pokemon.user == grace
    loop do
      rental.user = User.all.sample
      break unless rental.pokemon.user == rental.user  # if owner is also renter, get a new renter
    end
  else
    rental.user = grace
  end
  rental.price = rental.pokemon.price * Faker::Number.between(from: 1, to: 10)
  rental.save!
end

4.times do
  rental = Rental.new(
    start_date: "2020-09-15",
    end_date: "2020-09-22",
    pokemon: Pokemon.all.sample
  )
  if rental.pokemon.user == grace
    loop do
      rental.user = User.all.sample
      break unless rental.pokemon.user == rental.user  # if owner is also renter, get a new renter
    end
  else
    rental.user = grace
  end
  rental.price = rental.pokemon.price * Faker::Number.between(from: 1, to: 10)
  rental.save!
end

4.times do
  rental = Rental.new(
    start_date: "2020-12-24",
    end_date: "2020-12-31",
    pokemon: Pokemon.all.sample
  )
  if rental.pokemon.user == grace
    loop do
      rental.user = User.all.sample
      break unless rental.pokemon.user == rental.user  # if owner is also renter, get a new renter
    end
  else
    rental.user = grace
  end
  rental.price = rental.pokemon.price * Faker::Number.between(from: 1, to: 10)
  rental.save!
end

puts "seeded rentals!"

puts "seeding reviews..."

# Reviews - 12
Rental.all.each do |rental|
  review = Review.new(
    description: ['This Pokemon sucks!', 'This Pokemon is the best!', 'Eh, it was kind of okay.'].sample,
    rating: Faker::Number.between(from: 0, to: 5),
    rental: rental
  )
  review.save!
end

puts "seeded reviews!"