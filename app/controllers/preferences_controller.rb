class PreferencesController < ApplicationController
  def index
  end

  def save_preference
    all = Preference.all.map { |p| p.id }
    current = current_user.preference_ids
    selected = params[:user][:preference_ids].delete_if(&:blank?).map { |id| id.to_i }
    destroy_users_preferences(current - selected)
    create_users_preferences(selected - current)
    redirect_to root_path
  end

  def update
  end

  private

  def destroy_users_preferences(arr)
    arr.each do |pid|
      UsersPreference.find_by(preference_id: pid).destroy
    end
  end

  def create_users_preferences(arr)
    arr.each do |pid|
      UsersPreference.create(
        user: current_user,
        preference_id: pid
      )
    end
  end
end
