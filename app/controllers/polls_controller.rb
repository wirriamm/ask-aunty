class PollsController < ApplicationController
  def create
    @poll = Poll.new(meal: Meal.find(params[:meal]),
                     user: User.find(params[:user]),
                     cuisine: Cuisine.find(params[:cuisine]),
                     score: params[:score])
    redirect_to setup_path(@meal) if @poll.save
  end
end
