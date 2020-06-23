class AddDishToCuisines < ActiveRecord::Migration[6.0]
  def change
    add_column :cuisines, :dish, :string
  end
end
