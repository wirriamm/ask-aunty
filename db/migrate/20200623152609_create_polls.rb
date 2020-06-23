class CreatePolls < ActiveRecord::Migration[6.0]
  def change
    create_table :polls do |t|
      t.references :user, null: false, foreign_key: true
      t.references :meal, null: false, foreign_key: true
      t.references :cuisine, null: false, foreign_key: true
      t.boolean :score

      t.timestamps
    end
  end
end
