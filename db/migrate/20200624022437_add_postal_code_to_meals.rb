class AddPostalCodeToMeals < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :postal_code, :string
  end
end
