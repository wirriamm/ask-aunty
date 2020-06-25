class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
  end

  def join_meal
    @meal = Meal.new
  end

  def create_meal
    @meal = Meal.new
  end
end
