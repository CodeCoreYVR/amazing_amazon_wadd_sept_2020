# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

NUM_OF_USERS = 20
NUM_OF_PRODUCTS = 1000

Product.destroy_all()
User.destroy_all()

NUM_OF_PRODUCTS.times do
  created_at = Faker::Date.backward(365)
  Product.create({
    title: Faker::Cannabis.strain,
    description: Faker::Cannabis.health_benefit,
    price: rand(100_000),
    created_at: created_at,
    updated_at: created_at
  })
end

puts Cowsay.say("Created #{NUM_OF_PRODUCTS} products!", :sheep)

NUM_OF_USERS.times do
  User.create({
    first_name: Faker::Games::SuperSmashBros.fighter,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email
  })
end

puts Cowsay.say("Created #{NUM_OF_USERS}  users!", :turtle)

