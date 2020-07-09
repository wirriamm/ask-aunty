class AddCuisineReferenceToRestaurant < ActiveRecord::Migration[6.0]
  def change
    add_reference :restaurants, :cuisine, index: true
  end
end
