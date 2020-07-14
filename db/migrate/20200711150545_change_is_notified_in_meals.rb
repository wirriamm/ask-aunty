class ChangeIsNotifiedInMeals < ActiveRecord::Migration[6.0]
  def change
    change_column :meals, :is_notified, :boolean, default: false
  end
end
