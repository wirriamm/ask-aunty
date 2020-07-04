class Meal < ApplicationRecord
  has_many :users_meals, dependent: :destroy
  has_many :users, through: :users_meals
  has_many :polls, dependent: :destroy

  validates :postal_code, presence: true
  validates :vanity_id, presence: true, uniqueness: true
end
