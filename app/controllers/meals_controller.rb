class MealsController < ApplicationController
  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(
      vanity_id: generate_vanity_id,
      endtime: Time.now + 2.hours,
      postal_code: params[:meal][:postal_code]
      )
    if @meal.save
      redirect_to setup_path(@meal)
    else
      render :new
    end
  end

  def setup
    @cuisines = Cuisine.all
    @polls = []
    @meal = Meal.find(params[:id])
    @cuisines.each do |cuisine|
      poll_exist = Poll.find_by(cuisine: cuisine, meal: @meal, user: current_user)
      unless poll_exist
        new_poll = Poll.new(cuisine: cuisine, meal: @meal, user: current_user)
        @polls << new_poll
      end
    end
    @poll_no = 10 - @polls.length + 1
  end

  def result
    @meal = Meal.find(params[:id])
    @endtime = @meal.endtime
    @polls =  Poll.where(meal_id: @meal.id)
                  .select("cuisine_id, score")
                  .group("cuisine_id")
                  .order("cuisine_id").sum("score")
    # @poll_summary = @polls.select("cuisine_id, score").group("cuisine_id").sum("score").order("score")
    @polls_sorted = @polls.sort_by { |cuisine, score| score }
    @first = Cuisine.find(@polls_sorted.reverse.first[0])
    @second = Cuisine.find(@polls_sorted.reverse.second[0])
    @third = Cuisine.find(@polls_sorted.reverse.third[0])

    # @poll_summary.order(:value).reverse_order
    # @poll_summary = {}
    # # @polls.each do |poll|
    # #   if poll.cuisine.name #exists in polls summary
    # #   else #create new hash
    # # end
  end

  private

  def generate_vanity_id
    loop do
      random_code = SecureRandom.alphanumeric(6)
      return random_code if Meal.find_by(vanity_id: random_code).nil?
    end
  end
end
