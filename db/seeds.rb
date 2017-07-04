# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!( name: 'Example User',
              email: 'user@example.com',
              password: 'foobar',
              password_confirmation: 'foobar')

5.times do |i|
  name = Faker::HarryPotter.unique.character
  email = "user-#{i}@example.com"
  password = 'foobar'
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end

users = User.order(:created_at)
users.each do |u|
  # Seed Quotes for each user
  rand(1..10).times do
    body = Faker::HarryPotter.quote
    u.posts.create(body: body)
  end

  # Seed exercise_count for each user
  rand(1..10).times do
    u.exercises.create
  end
end

# Seed Administrator Role
User.create!( name: 'Administrator',
              email: 'admin@example.com',
              password: 'foobar',
              password_confirmation: 'foobar',
              admin: true)