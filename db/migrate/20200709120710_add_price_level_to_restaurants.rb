class AddPriceLevelToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :price_level, :integer
  end
end
