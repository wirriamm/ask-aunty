# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Destroy all cuisines
Cuisine.destroy_all

def create_cuisine(name)
  cuis = Cuisine.new(name: name)
  cuis.save!
end

puts "Creating cuisines"
cuisines = %W[Western Japanese Korean Chinese Thai Vietnamese Indonesian Mexican Italian]
cuisines.each do |cuisine|
  create_cuisine(cuisine)
  puts "#{Cuisine} created"
end
