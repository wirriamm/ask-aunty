# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroy all cuisines"
Cuisine.destroy_all
puts "Destroy all preferences"
Preference.destroy_all
puts "Destroy all users"
User.destroy_all

puts "Seeding users"
john = User.new(email: 'john@gmail.com',
                password: 'topsecret',
                password_confirmation: 'topsecret')
john.save!
puts "john seeded"

jane = User.new(email: 'jane@gmail.com',
                password: 'topsecret',
                password_confirmation: 'topsecret')
jane.save!
puts "jane seeded"

jack = User.new(email: 'jack@gmail.com',
                password: 'topsecret',
                password_confirmation: 'topsecret')
jack.save!
puts "jack seeded"

jill = User.new(email: 'jill@gmail.com',
                password: 'topsecret',
                password_confirmation: 'topsecret')
jill.save!
puts "jill seeded"

# Cuisines preferences
cuisines = %W[American Arabic Asian Australian Brazilian British Cantonese Chinese European French Fusion German Hunan Indian Indonesian International Italian Japanese Korean Malaysian Mediterranean Mexican Middle Eastern Modern Indian Modernist European Nepali Singaporean Spanish Sichuan Taiwanese Thai Turkish Vietnamese Western]

def create_cuisine(name, filename)
  cuis = Cuisine.new(name: name)
  # cuis.photo.attach(io: file, filename: filename, content_type: 'image/png')
  cuis.save!
end

puts "Seeding all cuisines"
cuisines.each do |cuisine|
  filename = "seeds-imgs#{cuisine}.jpg"
  create_cuisine(cuisine, filename)
  puts "#{cuisine} created"
end

# Seeds preferences
preferences = ['no spicy', 'no raw fish', 'no fast food']
restrictions = ['halal', 'gluten free', 'kosher', 'vegan', 'vegetarian', 'allergic to seafood', 'allergic to peanuts', 'lactose free']
seeds = preferences + restrictions

puts "Seeding all preferences."
seeds.each do |pref|
  preference = Preference.new(name: pref)
  if preference.save
    puts "Seeded #{preference.name}."
  end
end
puts "Seeded #{Preference.count} preferences."
