class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :place_id
      t.string :vicinity
      t.float :rating
      t.string :website
      t.string :formatted_phone_number
      t.string :url

      t.timestamps
    end
  end
end
