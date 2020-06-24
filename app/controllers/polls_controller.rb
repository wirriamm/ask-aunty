class PollsController < ApplicationController
  def create
    @meal = Meal.find(params[:meal_id])
    @poll = Poll.new(poll_params)
    @poll.user = current_user
    @poll.meal = @meal
    @poll.save
  end

  private

  def poll_params
    params.require(:poll).permit(:cuisine, :score)
  end
end
