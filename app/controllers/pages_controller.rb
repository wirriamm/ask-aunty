class PagesController < ApplicationController
  def home
  end

  def join_meal
    @meal = Meal.new
  end

  def create_meal
    @meal = Meal.new
  end
end
