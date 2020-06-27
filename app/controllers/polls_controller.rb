class PollsController < ApplicationController
  def create
    @meal = Meal.find(params[:meal])
    @poll = Poll.new(meal: @meal,
                     user: User.find(params[:user]),
                     cuisine: Cuisine.find(params[:cuisine]),
                     score: params[:score])

    respond_to do |format|
      if @poll.save
        format.html do
          redirect_to setup_path(@meal)
        end
        format.json { render json: @poll.to_json }
      end
    end
  end
end
