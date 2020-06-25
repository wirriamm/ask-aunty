class Meal < ApplicationRecord
  has_many :users_meals
  has_many :users, through: :users_meals
  has_many :polls

  validates :vanity_id, uniqueness: true
end
