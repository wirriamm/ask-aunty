class Meal < ApplicationRecord
  has_many :users_meals, dependent: :destroy
  has_many :users, through: :users_meals
  has_many :polls, dependent: :destroy

  validates :postal_code, presence: true
  validates :vanity_id, presence: true, uniqueness: true
  validates :pax, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
