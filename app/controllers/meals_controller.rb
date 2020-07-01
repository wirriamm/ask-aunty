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
      redirect_to setup_path @meal, notice: "Meal ID: #{@meal.vanity_id}"
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
    @top_cuisine = []
    @top_cuisine << Cuisine.find(@polls_sorted.reverse.first[0])
    @top_cuisine << Cuisine.find(@polls_sorted.reverse.second[0])
    @top_cuisine << Cuisine.find(@polls_sorted.reverse.third[0])

    # Remove duplicates of users
    # Collect preferences of each user
    # Remove duplicates of preferences
    @collated_prefs = @meal.users.uniq.flat_map { |u| u.preferences }.uniq
  end

  private

  def generate_vanity_id
    loop do
      random_code = SecureRandom.alphanumeric(6)
      return random_code if Meal.find_by(vanity_id: random_code).nil?
    end
  end

  def find_users_for_meal(meal)
    users_meals = UsersMeal.where(meal: meal).includes(:user)
    users = []
    users_meals.each do |users_meal|
      users << users_meal.user
    end
    users
  end
end
