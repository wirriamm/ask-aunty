class PollsController < ApplicationController
  def create
    @meal = Meal.find(params[:meal_id])
    @cuisine = Cuisine.find(params[:poll][:cuisine])
    @poll = Poll.new(poll_params)
    @poll.user = current_user
    @poll.meal = @meal
    @poll.cuisine = @cuisine
    @poll.save
  end

  private

  def poll_params
    params.require(:poll).permit(:score)
  end
end
