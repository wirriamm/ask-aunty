class Preference < ApplicationRecord
  has_many :users_preferences, dependent: :destroy
  has_many :users, through: :users_preferences

  def to_label
    "<div class='pref-card card shadow-sm mb-3 content-centered'>
      <h3 class='#{icon_name} p-3 m-0' style='font-size: 30px'></h3>
      <h5 class='p-2 m-0'>#{name}</h5>
    </div>".html_safe
  end

  def icon_name
    case name
      when 'Vegetarian' then 'fa fa-leaf'
      when 'Pescatarian' then 'fas fa-fish'
      when 'No Spicy Food' then 'fas fa-pepper-hot'
      when 'Halal' then 'icon-halal'
    end
  end
end
