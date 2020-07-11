class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @meal = Meal.new
  end

  def ui_kit
  end

  def join_meal
    @meal = Meal.new
    @meal.vanity_id = params[:vanity_id]
  end

  def create_users_meal
    @meal = Meal.find_by(vanity_id: get_vanity_id)
    # Check if Meal ID exists
    if @meal.nil?
      @meal = Meal.new
      flash.now[:alert] = "Don't have Makan Code \"#{get_vanity_id}\" lah!"
      render :home
    # Cannot join meal once it is closed
    elsif @meal.endtime == nil || @meal.endtime < Time.now
      if user_in_meal?
        redirect_to result_path(@meal.vanity_id)
      else
        flash.now[:alert] = "Too late! \"#{get_vanity_id}\" close liao!"
        render :join_meal
      end
    else # Time not up yet
      if user_in_meal?
        redirect_to setup_path(@meal.vanity_id), notice: "Continue from where you left off"
      else
        users_meal = UsersMeal.create(user: current_user, meal: @meal)
        redirect_to setup_path(@meal.vanity_id), success: "Welcome to the makan gang!"
      end
      # If user completed the poll, meals#setup controller will show a 'Show Results' button.
    end
  end

  private

  def get_vanity_id
    params[:meal][:vanity_id]
  end

  def user_in_meal?
    current_user.meals.include? @meal
  end
end
