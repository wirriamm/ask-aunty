# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seeds preferences
preferences = ['no spicy', 'no raw fish', 'no fast food']
restrictions = ['halal', 'gluten free', 'kosher', 'vegan', 'vegetarian', 'allergic to seafood', 'allergic to peanuts', 'lactose free']
seeds = preferences + restrictions

puts "Destroy all preferences"
Preference.destroy_all

puts "Seeding all preferences."
seeds.each do |pref|
  preference = Preference.new(name: pref)
  if preference.save
    puts "Seeded #{preference.name}."
  end
end
puts "Seeded #{Preference.count} preferences."
