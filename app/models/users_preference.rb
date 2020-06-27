class UsersPreference < ApplicationRecord
  belongs_to :preference
  belongs_to :user

  def to_label
    "#{self.preference.name}"
  end
end
