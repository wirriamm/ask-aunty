# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

# puts "Destroy all cuisines"
# Cuisine.destroy_all
puts "Destroy all preferences"
Preference.destroy_all
puts "Destroy all meals"
Meal.destroy_all
puts "Destroy all users"
User.destroy_all
puts

# Cuisines preferences
# cuisines = %W[American Arabic Asian Australian Brazilian British Cantonese Chinese European French Fusion German Hunan Indian Indonesian International Italian Japanese Korean Malaysian Mediterranean Mexican Middle Eastern Modern Indian Modernist European Nepali Singaporean Spanish Sichuan Taiwanese Thai Turkish Vietnamese Western]
# cuisines = %W[Chinese Japanese Korean Singaporean Thai Vietnamese Mexican Indonesian Indian Western]

cuisines = [
  { name: 'Thai',
    dish: 'Tom yum',
    url: 'https://www.killingthyme.net/wp-content/uploads/2015/06/Tom-Yum-Soup.jpg'},
  { name: 'Chinese',
    dish: 'Steamed fish',
    url: 'https://asianinspirations.com.au/wp-content/uploads/2018/07/R00705_ChineseSteamed-Fish.jpg'},
  { name: 'Japanese',
    dish: 'Sushi',
    url: 'https://www.edgemagazine.net/wp-content/uploads/2018/02/duffel.jpg'},
  { name: 'Korean',
    dish: 'Bimbimbap',
    url: 'https://i0.wp.com/www.agoda.com/wp-content/uploads/2019/05/Seoul-food-Seoul-Korean-BBQ-family-style-meal.jpg'},
  { name: 'Singaporean',
    dish: 'Chilli crab',
    url: 'https://www.jetstar.com/_/media/inspiration-hub/article-images/19feb/this-is-the-person-who-created-the-singapore-chilli-crab/hero_chilli_crab.jpg?rev=1a56cfb9c3b24bc89b158f6c2175ca42&w=1050&rc=1&cw=1050&ch=590&cx=55&cy=0&hash=81188182BAA3AF0AE54FBE96F370DD5463855D8E'},
  { name: 'Vietnamese',
    dish: 'Pho',
    url: 'https://www.capitaland.com/content/dam/capitaland-media-library/retail/Singapore/Singapore/cma-tenants/sopho.jpg.transform/cap-midres/image.jpg'},
  { name: 'Mexican',
    dish: 'Tacos',
    url: 'https://hips.hearstapps.com/del.h-cdn.co/assets/18/11/1520956952-chicken-tacos-horizontal.jpg'},
  { name: 'Indonesian',
    dish: 'Ayam penyet',
    url: 'https://magazine.foodpanda.my/wp-content/uploads/sites/12/2019/11/cropped-Ayam-Penyet-Best-Delivery-in-Kuala-Lumpur.jpg'},
  { name: 'Indian',
    dish: 'Naan',
    url: 'https://www.khaosodenglish.com/wp-content/uploads/2019/08/CIB_1-1068x601.jpg'},
  { name: 'Western',
    dish: 'Steak',
    url: 'https://www.seriouseats.com/recipes/images/2015/05/Anova-Steak-Guide-Sous-Vide-Photos15-beauty-1500x1125.jpg'}
]

puts "Seeding all cuisines"
cuisines.each do |attribs|
  file = URI.open(attribs[:url])
  cuis = Cuisine.new(name: attribs[:name], dish: attribs[:dish])
  cuis.photo.attach(io: file, filename: attribs[:name], content_type: 'image/png')
  cuis.save!
  puts "#{attribs[:name]} created"
end
puts

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
puts

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
