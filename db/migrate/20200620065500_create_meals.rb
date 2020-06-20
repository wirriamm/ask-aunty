class CreateMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :meals do |t|
      t.string :vanity_id
      t.datetime :endtime

      t.timestamps
    end
  end
end
