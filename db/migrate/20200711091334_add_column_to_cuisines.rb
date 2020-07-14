class AddColumnToCuisines < ActiveRecord::Migration[6.0]
  def change
    add_column :cuisines, :vegetarian, :string
    add_column :cuisines, :pescatarian, :string
    add_column :cuisines, :no_spicy_food, :string
  end
end
