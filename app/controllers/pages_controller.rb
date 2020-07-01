class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  # def landing
  # end

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
      flash.now[:alert] = "Don't have Meal ID \"#{get_vanity_id}\" lah!"
      render :join_meal
    else
      # Check if user has already joined this meal
      if current_user.meals.include? @meal
        redirect_to setup_path(@meal), notice: "Continue from where you left off"
      else
        users_meal = UsersMeal.create(user: current_user, meal: @meal)
        redirect_to setup_path(@meal), success: "Welcome to the makan gang!"
      end
      # If user completed the poll, meals#setup controller will show a 'Show Results' button.
    end
  end

  private

  def get_vanity_id
    params[:meal][:vanity_id]
  end
end
