# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Создаем пользователей
5.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 10),
  )
end

users = User.all

# Создаем фотографии
20.times do
  Photo.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.sentence(word_count: 10),
    price: Faker::Commerce.price(range: 10..100.0),
  )
end

# Создаем заказы для каждого пользователя
users.each do |user|
  order = Order.create!(user: user, total_price: Faker::Commerce.price(range: 100..500.0), status: ['pending', 'completed', 'shipped'].sample)

  3.times do
    LineItem.create!(
      itemable: order,
      photo: Photo.order(Arel.sql('RANDOM()')).first,
      quantity: rand(1..3),
      price: Faker::Commerce.price(range: 10..100.0)
    )
  end
end

puts "Seed data created successfully!"
