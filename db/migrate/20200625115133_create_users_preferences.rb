class CreateUsersPreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :users_preferences do |t|
      t.references :preference, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
