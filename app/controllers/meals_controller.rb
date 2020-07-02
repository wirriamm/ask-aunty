require "selenium-webdriver"

class MealsController < ApplicationController
  def index
    @users_meals = UsersMeal.where(user: current_user).includes(:meal)
  end

  def new
    @meal = Meal.new(
      endtime: Time.now + 2.hours
    )
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
    @meal = Meal.find(params[:id])
    @cuisines = Cuisine.all
    @polls = []
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
    @time_left = get_time_left
    @polls = Poll.where(meal_id: @meal.id)
                  .select("cuisine_id, score")
                  .group("cuisine_id")
                  .order("cuisine_id").sum("score")
    @total_polls = @polls.count
    if @polls != {}
      @polls_sorted = @polls.sort_by { |_cuisine, score| score }
      @polls_sorted.map
      @top_cuisine = []
      @top_cuisine << Cuisine.find(@polls_sorted.reverse.first[0]) if @polls_sorted.reverse.first
      @top_cuisine << Cuisine.find(@polls_sorted.reverse.second[0]) if @polls_sorted.reverse.second
      @top_cuisine << Cuisine.find(@polls_sorted.reverse.third[0]) if @polls_sorted.reverse.third
      @top_cuisine_score = []
      @top_cuisine_score << @polls_sorted.reverse.first[1] if @polls_sorted.reverse.first
      @top_cuisine_score << @polls_sorted.reverse.second[1] if @polls_sorted.reverse.second
      @top_cuisine_score << @polls_sorted.reverse.third[1] if @polls_sorted.reverse.third
    end

    # Remove duplicates of users
    # Collect preferences of each user
    all_prefs = @meal.users.uniq.flat_map(&:preferences)
    # Remove duplicates of preferences
    @collated_prefs = all_prefs.uniq

    if (Time.now < @meal.endtime) && (@meal.endtime != nil)
      @fortune = fortune
    end
  end

  private

  def generate_vanity_id
    loop do
      random_code = SecureRandom.alphanumeric(6)
      return random_code if Meal.find_by(vanity_id: random_code).nil?
    end
  end

  def get_time_left
    helpers.distance_of_time_in_words(Time.now, @meal.endtime)
  end

  def fortune
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    driver.navigate.to "http://www.fortunecookiemessage.com/"
    # driver.navigate.to "https://generatorfun.com/fortune-cookie-generator"
    fortune_cookie = driver.find_element(:class, "cookie-link" )
    txt = fortune_cookie.text.strip
    # ff = []
    # fortune_cookie.each do |f|
    #   ff << f.text.strip
    # end
    driver.quit
    txt
  end
end
