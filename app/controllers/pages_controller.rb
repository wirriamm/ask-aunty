class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
  end

  def join_meal
    @meal = Meal.new
  end

  def create_users_meal
    @meal = Meal.find_by(vanity_id: get_vanity_id)
    # Check if Meal ID exists
    if @meal.nil?
      @meal = Meal.new
      render :join_meal, alert: "Meal ID #{get_vanity_id} not found"
    else
      # Check if user have already joined this meal
      if @meal.users.include? current_user
        redirect_to root_path # TO BE REMOVED
        # redirect_to result_path
      else
        @meal.users << current_user
        @meal.save
        redirect_to root_path # TO BE REMOVED
        # redirect_to preferences_path
      end
    end
  end

  private

  def get_vanity_id
    params[:meal][:vanity_id]
  end
end
