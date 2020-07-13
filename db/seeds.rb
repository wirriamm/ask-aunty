# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

puts "Destroy all preferences"
Preference.destroy_all
puts "Destroy all cuisines"
Cuisine.destroy_all
puts "Destroy all meals"
Meal.destroy_all
puts "Destroy all users"
User.destroy_all

# Cuisines preferences
# cuisines = %W[American Arabic Asian Australian Brazilian British Cantonese Chinese European French Fusion German Hunan Indian Indonesian International Italian Japanese Korean Malaysian Mediterranean Mexican Middle Eastern Modern Indian Modernist European Nepali Singaporean Spanish Sichuan Taiwanese Thai Turkish Vietnamese Western]
# cuisines = %W[Chinese Japanese Korean Singaporean Thai Vietnamese Mexican Indonesian Indian Western]

# Seeds preferences
preferences = ['Vegetarian', 'Pescatarian', 'No Spicy Food']
restrictions = ['Halal']
seeds = preferences + restrictions

puts "Seeding all preferences."
seeds.each do |pref|
  preference = Preference.new(name: pref)
  if preference.save
    puts "Seeded #{preference.name}."
  end
end
puts "Seeded #{Preference.count} preferences."
cuisines = [
  { name: 'Thai',
    # dish: 'Tom yum',
    url: ['https://www.killingthyme.net/wp-content/uploads/2015/06/Tom-Yum-Soup.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/x6nv-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/x6bx-hero.jpg?',
          'https://lh3.googleusercontent.com/zaQtjTWatNGYbMISzipM3eSt0C9UnyrrWh25broU4ZyR6VJI1aaUCYvPQcOUOVcZU9HKKwFUavnWEIZE-u6I2g=s640-c-rw-v1-e365',
          'https://lh3.googleusercontent.com/JGzLsQ2UDy_u4ULkda_rZrnGJceCEiuoDQKrxoi6-Oix1WHmgremPkdEcNUj3miarJ_AYqlVZpDF3Q4ZCsNF=s640-c-rw-v1-e365'],
    vegetarian: "Green Mango Salad",
    pescatarian: "Tom Yum Soup",
    no_spicy_food: "Pad Thai"
  },

  { name: 'Chinese',
    # dish: 'Steamed fish',
    url: ['https://asianinspirations.com.au/wp-content/uploads/2018/07/R00705_ChineseSteamed-Fish.jpg',
          "https://images.deliveryhero.io/image/fd-sg/LH/y2fl-hero.jpg",
          "https://images.deliveryhero.io/image/fd-sg/LH/j7eb-hero.jpg",
          "https://images.deliveryhero.io/image/fd-sg/LH/y6bt-hero.jpg",
          "https://images.deliveryhero.io/image/fd-sg/LH/y3ce-hero.jpg",
          "https://images.deliveryhero.io/image/fd-sg/LH/x7bz-hero.jpg"],
    vegetarian: "Tofu Fried Rice",
    pescatarian: "Shrimp Lo Mein",
    no_spicy_food: "Sweet and Sour Pork"
  },

  { name: 'Japanese',
    # dish: 'Sushi',
    url: ['https://www.edgemagazine.net/wp-content/uploads/2018/02/duffel.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/w5ua-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/y1oe-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/x6oc-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/w8ob-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/y9og-hero.jpg'],
    vegetarian: "Vegetable Tempura",
    pescatarian: "Sushi",
    no_spicy_food: "Udon Soup"
  },

  { name: 'Korean',
    # dish: 'Bimbimbap',
    url: ['https://i0.wp.com/www.agoda.com/wp-content/uploads/2019/05/Seoul-food-Seoul-Korean-BBQ-family-style-meal.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/w0ij-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/x6xv-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/x5qj-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/s2ob-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/s5pw-hero.jpg'],
    vegetarian: "Jap Chae",
    pescatarian: "Seafood Pancake",
    no_spicy_food: "Sam Gae Tang"
  },

  { name: 'Singaporean',
    # dish: 'Chilli crab',
    url: ['https://www.jetstar.com/_/media/inspiration-hub/article-images/19feb/this-is-the-person-who-created-the-singapore-chilli-crab/hero_chilli_crab.jpg?rev=1a56cfb9c3b24bc89b158f6c2175ca42&w=1050&rc=1&cw=1050&ch=590&cx=55&cy=0&hash=81188182BAA3AF0AE54FBE96F370DD5463855D8E',
          'https://images.deliveryhero.io/image/fd-sg/LH/t9ca-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/j2vg-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/x5wb-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/x3bk-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/w3tu-hero.jpg'],
    vegetarian: "Roti Prata",
    pescatarian: "Laksa",
    no_spicy_food: "Hainanese Chicken Rice"
  },

  { name: 'Vietnamese',
    # dish: 'Pho',
    url: ['https://www.capitaland.com/content/dam/capitaland-media-library/retail/Singapore/Singapore/cma-tenants/sopho.jpg.transform/cap-midres/image.jpg',
          'https://burpple-1.imgix.net/foods/63ceedb6eef116614dc1553447_original.?w=645&dpr=1&fit=crop&q=80&auto=format',
          'https://burpple-3.imgix.net/foods/2f70ab78fbaed9909c9c1845330_original.?w=645&dpr=1&fit=crop&q=80&auto=format',
          'https://burpple-2.imgix.net/foods/3f5b6ac2b1f36b6478e1430769_original.?w=645&dpr=1&fit=crop&q=80&auto=format',
          'https://burpple-1.imgix.net/foods/17f3b3d92994d23f41445063_original.?w=645&dpr=1&fit=crop&q=80&auto=format'],
    vegetarian: "Vegetarian Bun Chay",
    pescatarian: "Summer Rolls with Shrimp",
    no_spicy_food: "Pho"
  },

  { name: 'Mexican',
    # dish: 'Tacos',
    url: ['https://hips.hearstapps.com/del.h-cdn.co/assets/18/11/1520956952-chicken-tacos-horizontal.jpg',
          'https://www.topuniversities.com/sites/default/files/styles/lead_article_image/public/blogs/lead-images/mexican-food-2.jpg',
          'https://www.topuniversities.com/sites/default/files/huevos-rancheros.jpg',
          'https://www.topuniversities.com/sites/default/files/chilaquiles.jpg',
          'https://www.topuniversities.com/sites/default/files/tacos-al-pastor_0.jpg',
          'https://www.onceuponachef.com/images/2018/03/Breakfast-Burritos-760x569.jpg'],
    vegetarian: "Guacamole",
    pescatarian: "Fish Tamale",
    no_spicy_food: "Enchiladas"
  },

  { name: 'Indonesian',
    # dish: 'Ayam penyet',
    url: ['https://magazine.foodpanda.my/wp-content/uploads/sites/12/2019/11/cropped-Ayam-Penyet-Best-Delivery-in-Kuala-Lumpur.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/v6tq-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/v7rr-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/z3od-hero.jpg',
          'https://www.fodors.com/wp-content/uploads/2019/04/05_TraditionalfoodsinJava__GadoGado_shutterstock_1134726908.jpg'],
    vegetarian: "Gado-Gado",
    pescatarian: "Ikan Goreng",
    no_spicy_food: "Soto Mie/Ayam"
  },

  { name: 'Indian',
    # dish: 'Naan',
    url: ['https://www.khaosodenglish.com/wp-content/uploads/2019/08/CIB_1-1068x601.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/x1py-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/w9hw-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/w8rf-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/x0fu-hero.jpg'],
    vegetarian: "Masala Thosai",
    pescatarian: "Fish Curry",
    no_spicy_food: "Butter Chicken"
  },

  { name: 'Western',
    # dish: 'Steak',
    url: ['https://www.seriouseats.com/recipes/images/2015/05/Anova-Steak-Guide-Sous-Vide-Photos15-beauty-1500x1125.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/x0nh-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/x5nu-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/w4hj-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/x7ns-hero.jpg',
          'https://images.deliveryhero.io/image/fd-sg/LH/s9em-hero.jpg'],
    vegetarian: "Vegetarian Caesar Salad",
    pescatarian: "Grilled Salmon",
    no_spicy_food: "Beef Burger"
  }
]

puts "Seeding all cuisines"
cuisines.each do |attribs|
  cuis = Cuisine.new(name: attribs[:name])#, dish: attribs[:dish])
  attribs[:url].each_with_index do |url, index|
    file = URI.open(url)
    cuis.photos.attach(io: file, filename: "#{attribs[:name]} #{index + 1}", content_type: 'image/png')
  end
  cuis.save!
  puts "#{attribs[:name]} created"
  sleep(60)
end
puts "All cuisines seeded"


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

puts "Seeding test meal for john"
meal = Meal.new(vanity_id: 'TEST123',
                postal_code: 238869,
                endtime: Time.now )
meal.save!

users_meal = UsersMeal.new(user: john,
                            meal: meal )
users_meal.save!
puts "test meal seeded"
