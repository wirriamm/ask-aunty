class Cuisine < ApplicationRecord
  has_many_attached :photos
  has_many :polls, dependent: :destroy
end
