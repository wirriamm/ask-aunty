class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # relationship
  has_many :users_meals, dependent: :destroy
  has_many :meals, through: :users_meals

  has_many :polls, dependent: :destroy

  has_many :users_preferences, dependent: :destroy
  has_many :preferences, through: :users_preferences
end
