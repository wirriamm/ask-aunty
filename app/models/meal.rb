class Meal < ApplicationRecord
  has_many :users_meals, dependent: :destroy
  has_many :users, through: :users_meals
  has_many :polls, dependent: :destroy

  validates :vanity_id, presence: true, uniqueness: true
  validates :postal_code, presence: true, length: { is: 6}, numericality: { only_integer: true }
  geocoded_by :address
  after_validation :geocode


  private

  def address
    "Singapore, #{postal_code}"
  end
end
