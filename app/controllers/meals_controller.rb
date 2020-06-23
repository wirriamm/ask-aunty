class MealsController < ApplicationController
  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(
      vanity_id: generate_vanity_id,
      endtime: Time.now + 2.hours
      )
    if @meal.save
      redirect_to '/' # change to preferences path
    else
      render new
    end
  end

  def show
  end

  private

  def generate_vanity_id
    loop do
      random_code = SecureRandom.alphanumeric
      return random_code if Meal.find_by(vanity_id: random_code).nil?
    end
  end
end
