class MealsController < ApplicationController
  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(
      vanity_id: 'XXX',
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
    # Incomplete
    Meal.find_by(vanity_id: 'XXX')
  end
end
