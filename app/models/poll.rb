class Poll < ApplicationRecord
  belongs_to :user
  belongs_to :meal
  belongs_to :cuisine
end
