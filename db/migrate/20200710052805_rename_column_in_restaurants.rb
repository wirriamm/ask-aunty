class RenameColumnInRestaurants < ActiveRecord::Migration[6.0]
  def change
    rename_column :restaurants, :vicinity, :formatted_address
  end
end
