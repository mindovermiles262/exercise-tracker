User.destroy_all if Rails.env.development?
Post.destroy_all if Rails.env.development?
Exercise.destroy_all if Rails.env.development?

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
  rand(1..2).times do
    u.exercises.create(exercise_time: Time.zone.now)
  end
end

# Seed Administrator Role
User.create!( name: 'Administrator',
              email: 'admin@example.com',
              password: 'foobar',
              password_confirmation: 'foobar',
              admin: true)