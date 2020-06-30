class MealsController < ApplicationController
  def index
    @users_meals = UsersMeal.where(user: current_user).includes(:meal)
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(
      vanity_id: generate_vanity_id,
      endtime: Time.now + 2.hours,
      postal_code: params[:meal][:postal_code]
      )
    UsersMeal.create(user: current_user, meal: @meal)
    if @meal.save
      redirect_to setup_path(@meal, test: "test", notice: "2 Meal ID: #{@meal.vanity_id}"), notice: "Meal ID: #{@meal.vanity_id}"
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
    @total_polls = @polls.count
    if @polls != {}
      @polls_sorted = @polls.sort_by { |cuisine, score| score }
      @polls_sorted.map
      @top_cuisine = []
      @top_cuisine << Cuisine.find(@polls_sorted.reverse.first[0]) if @polls_sorted.reverse.first
      @top_cuisine << Cuisine.find(@polls_sorted.reverse.second[0])if @polls_sorted.reverse.second
      @top_cuisine << Cuisine.find(@polls_sorted.reverse.third[0]) if @polls_sorted.reverse.third
      @top_cuisine_score = []
      @top_cuisine_score << @polls_sorted.reverse.first[1] if @polls_sorted.reverse.first
      @top_cuisine_score << @polls_sorted.reverse.second[1]if @polls_sorted.reverse.second
      @top_cuisine_score << @polls_sorted.reverse.third[1] if @polls_sorted.reverse.third
    end
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
