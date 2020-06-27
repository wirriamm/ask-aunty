class AddStatusToUsersPreferences < ActiveRecord::Migration[6.0]
  def change
    add_column :users_preferences, :status, :boolean
  end
end
