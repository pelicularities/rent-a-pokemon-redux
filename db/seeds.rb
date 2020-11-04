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

# Users - 20
users = [
  {
    username: 'demo',
    password: 'demo12345'
  }
]
19.times do 
  users << {
    username: Faker::Internet.unique.username,
    password: Faker::Internet.password(min_length: 8)
  }
end


users.each do |user|
  User.create!(user)
  puts "seeded #{user[:username]}"
end

puts "seeded users!"

puts "seeding Pokemon..."

# Pokemon - 60
15.times do
  pokemon = Pokemon.create!(
    name: Faker::Name.unique.first_name,
    description: Faker::Lorem.sentence,
    price: Faker::Number.between(from: 10, to: 120),
    location: Faker::Games::Pokemon.location,
    user: User.find_by_username('demo'),
    pokedex: Pokedex.all.sample
  )
  puts "seeded #{pokemon.name} (#{pokemon.pokedex.species}, #{pokemon.user.username})"
end
45.times do
  pokemon = Pokemon.new(
    name: Faker::Name.unique.first_name,
    description: Faker::Lorem.sentence,
    price: Faker::Number.between(from: 10, to: 120),
    location: Faker::Games::Pokemon.location,
    pokedex: Pokedex.all.sample
  )
  loop do
    pokemon.user = User.all.sample
    break unless pokemon.user == User.find_by_username('demo')
  end
  pokemon.save!
  puts "seeded #{pokemon.name} (#{pokemon.pokedex.species}, #{pokemon.user.username})"
end

puts "seeded Pokemon!"

puts "seeding rentals..."

demo = User.find_by_username('demo')

# Rentals - 120
40.times do
  rental = Rental.new(
    start_date: (Time.now - 86400 * Faker::Number.between(from: 7, to: 10)).strftime('%F'),
    end_date: (Time.now - 86400 * Faker::Number.between(from: 3, to: 5)).strftime('%F'),
    pokemon: Pokemon.all.sample
  )
  if rental.pokemon.user == demo
    loop do
      rental.user = User.all.sample
      break unless rental.pokemon.user == rental.user  # if owner is also renter, get a new renter
    end
  else
    rental.user = demo
  end
  rental.price = rental.pokemon.price * Faker::Number.between(from: 1, to: 10)
  rental.save!
end

40.times do
  rental = Rental.new(
    start_date: (Time.now - 86400 * Faker::Number.between(from: 3, to: 5)).strftime('%F'),
    end_date: (Time.now + 86400 * Faker::Number.between(from: 3, to: 5)).strftime('%F'),
    pokemon: Pokemon.all.sample
  )
  if rental.pokemon.user == demo
    loop do
      rental.user = User.all.sample
      break unless rental.pokemon.user == rental.user  # if owner is also renter, get a new renter
    end
  else
    rental.user = demo
  end
  rental.price = rental.pokemon.price * Faker::Number.between(from: 1, to: 10)
  rental.save!
end

40.times do
  rental = Rental.new(
    start_date: (Time.now - 86400 * Faker::Number.between(from: 3, to: 5)).strftime('%F'),
    end_date: (Time.now - 86400 * Faker::Number.between(from: 7, to: 10)).strftime('%F'),
    pokemon: Pokemon.all.sample
  )
  if rental.pokemon.user == demo
    loop do
      rental.user = User.all.sample
      break unless rental.pokemon.user == rental.user  # if owner is also renter, get a new renter
    end
  else
    rental.user = demo
  end
  rental.price = rental.pokemon.price * Faker::Number.between(from: 1, to: 10)
  rental.save!
end

puts "seeded rentals!"

puts "seeding reviews..."

# Reviews - all rentals get one review
possible_reviews = [
  {
    description: 'This Pokemon sucks!',
    rating: 1
  },
  {
    description: 'Eh, it was kind of okay.',
    rating: 3
  },
  {
    description: 'This Pokemon is the best!',
    rating: 5
  }
]

Rental.all.each do |rental|
  review_details = possible_reviews.sample
  review = Review.new(
    description: review_details[:description],
    rating: review_details[:rating],
    rental: rental
  )
  review.save!
end

puts "seeded reviews!"