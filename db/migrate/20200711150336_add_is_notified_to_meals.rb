class AddIsNotifiedToMeals < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :is_notified, :boolean
  end
end
