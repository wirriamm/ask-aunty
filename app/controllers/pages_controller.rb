class PagesController < ApplicationController
  def home
  end

  def join_meal
    @meal = Meal.new
  end

  def create_users_meal
    @meal = Meal.new
  end
end
