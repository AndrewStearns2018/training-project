# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

User.destroy_all
puts "destroyed all users"

FactoryBot.create(:user)
puts "created User"

Category.destroy_all
puts "destroyed all categories"

FactoryBot.create(:category)
puts "created Category"

Project.destroy_all
puts "destroyed all projects"

FactoryBot.create(:project)
puts "created project"

Reward.destroy_all
puts "destroyed all rewards"

FactoryBot.create(:reward)
puts "created award"

Contribution.destroy_all
puts "destroyed all contributions"

FactoryBot.create(:contribution)
puts "contribution created"

