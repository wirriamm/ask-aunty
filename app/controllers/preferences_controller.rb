class PreferencesController < ApplicationController
  def index
    @preferences = Preference.all
    @users_preferences = []
    @preferences.each do |preference|
      if UsersPreference.find_by(user: current_user, preference: preference).present?
        @users_preferences << UsersPreference.find_by(user: current_user, preference: preference)
      else
        users_preference = UsersPreference.new(user: current_user, preference: preference)
        @users_preferences << users_preference
      end
    end
  end

  def create

  end

  def update

  end

  private

  def get_preference

  end
end
