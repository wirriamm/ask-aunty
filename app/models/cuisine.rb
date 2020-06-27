class Cuisine < ApplicationRecord
  has_one_attached :photo
  has_many :polls, dependent: :destroy
end
