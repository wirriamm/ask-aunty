class Preference < ApplicationRecord
  has_many :users_preferences, dependent: :destroy
  has_many :users, through: :users_preferences
end
