# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroy all cuisines"
Cuisine.destroy_all

def create_cuisine(name, filename)
  cuis = Cuisine.new(name: name)
  # cuis.photo.attach(io: file, filename: filename, content_type: 'image/png')
  cuis.save!
end

puts "Creating cuisines"

cuisines = %W[American Arabic Asian Australian Brazilian British Cantonese Chinese European French Fusion German Hunan Indian Indonesian International Italian Japanese Korean Malaysian Mediterranean Mexican Middle Eastern Modern Indian Modernist European Nepali Singaporean Spanish Sichuan Taiwanese Thai Turkish Vietnamese Western]

cuisines.each do |cuisine|
  filename = "seeds-imgs#{cuisine}.jpg"
  create_cuisine(cuisine, filename)
  puts "#{cuisine} created"
end
