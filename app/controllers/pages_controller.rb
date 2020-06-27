class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :landing

  def landing
  end

  def home
  end

  def join_meal
    @meal = Meal.new
  end

  def create_users_meal
    @meal = Meal.find_by(vanity_id: get_vanity_id)
    UsersMeal.create(user: current_user, meal: @meal)
    # Check if Meal ID exists
    if @meal.nil?
      @meal = Meal.new
      render :join_meal, alert: "Meal ID #{get_vanity_id} not found"
    else
      # Check if user have already joined this meal
      if @meal.users.include? current_user
        redirect_to result_path(@meal.id)
      else
        @meal.users << current_user
        @meal.save
        redirect_to setup_path(@meal)
      end
    end
  end

  private

  def get_vanity_id
    params[:meal][:vanity_id]
  end
end
