class PagesController < ApplicationController
  def home
  end

  def join_meal
    @meal = Meal.new
  end

  def create_users_meal
    # Check if Meal ID exists
    @meal = Meal.new
    render :join_meal, alert: "Meal ID #{get_vanity_id} not found" if Meal.find_by(vanity_id: get_vanity_id).nil?

    @meal = Meal.find_by(vanity_id: get_vanity_id)
    # Check if user have already joined this meal
    @users_meal = UsersMeal.find_by(user: current_user, meal: @meal)
    if @users_meal.nil?
      # Create new users_meal
      @users_meal = UsersMeal.new(user: current_user, meal: @meal)
      if @users_meal.save
        redirect_to preferences_path
      else
        render :join_meal, alert: "Failed to join meal #{get_vanity_id}"
      end
    else
      # Contnue the poll from where it is left off
      polls = Poll.where(user: current_user, meal: @meal)
      redirect_to root_path # To direct to polling page or verdict page
    end
  end

  private

  def get_vanity_id
    params[:meal][:vanity_id]
  end
end
