class MealsController < ApplicationController
  def index
    @users_meals = UsersMeal.where(user: current_user).includes(:meal)
    # raise
  end

  def new
    @meal = Meal.new(
      endtime: Time.now + 2.hours
    )
  end

  def show
    @meal = Meal.find_by(vanity_id: params[:vanity_id])
  end

  def create
    @meal = Meal.new(
      vanity_id: generate_vanity_id,
      endtime: Time.now + 2.hours,
      postal_code: params[:meal][:postal_code]
      )
    # raise
    if @meal.save
      UsersMeal.create(user: current_user, meal: @meal)
      redirect_to setup_path(@meal.vanity_id), notice: "Meal ID: #{@meal.vanity_id}"
    else
      render :new
    end
  end

  def setup
    @meal = Meal.find_by(vanity_id: params[:vanity_id])
    if @meal.nil?
      redirect_to root_path, alert: "Anyhow put wrong Meal ID..."
    else
      if @meal.users.exclude? current_user
        @meal.users << current_user
      end
      completed_cuisines = current_user.polls.where(meal: @meal).map(&:cuisine)
      remaining_cuisines = Cuisine.all - completed_cuisines
      @polls = remaining_cuisines.map do |c|
        Poll.new(cuisine: c, meal: @meal, user: current_user)
      end
      @poll_no = 10 - @polls.length + 1
    end
  end

  def result
    @meal = Meal.find_by(vanity_id: params[:vanity_id])
    @time_left = get_time_left
    @endtime = @meal.endtime
    @polls =  Poll.where(meal_id: @meal.id)
                  .select("cuisine_id, sum(score) as total_score")
                  .group("cuisine_id")
                  .order("total_score DESC")
                  .limit(3)
    @total_polls = Poll.where(meal_id: @meal.id)
                  .count
    if @endtime == nil
      return
    elsif (Time.now < @meal.endtime) && (@meal.endtime != nil)
      # @fortune = fortune
    end

    # Remove duplicates of users
    # Collect preferences of each user
    all_prefs = @meal.users.uniq.flat_map(&:preferences)
    # Remove duplicates of preferences
    @collated_prefs = all_prefs.uniq
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
