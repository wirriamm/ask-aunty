class CreateUsersMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :users_meals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :meal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
