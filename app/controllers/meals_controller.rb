class MealsController < ApplicationController
  def index
    @users_meals = UsersMeal.where(user: current_user).includes(:meal)
  end

  def new
    @meal = Meal.new(
      endtime: Time.now + 2.hours
    )
  end

  def show
    @meal = Meal.find_by(vanity_id: params[:vanity_id])
    @user_meal = UsersMeal.where(user: current_user, meal: @meal)
    if @user_meal.nil?
      @user_meal = UsersMeal.create!(user: current_user, meal: @meal)
    end
  end

  def create
    @meal = Meal.new(
      vanity_id: generate_vanity_id,
      endtime: Time.now + 2.hours,
      postal_code: params[:meal][:postal_code],
      pax: params[:meal][:pax]
      )
    if @meal.save
      UsersMeal.create(user: current_user, meal: @meal)
      redirect_to setup_path(@meal.vanity_id), notice: "Meal ID: #{@meal.vanity_id}"
    else
      flash.now[:alert] = "Postal Code not valid leh"
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
    @poll_no = 10 - @polls.length + 1
    @time_left = get_time_left
  end

  def result
    @meal = Meal.find_by(vanity_id: params[:vanity_id])
    @endtime = @meal.endtime

    @polls = Poll.where(meal_id: @meal.id)
                 .select("cuisine_id, sum(score) as total_score")
                 .group("cuisine_id")
                 .order("total_score DESC")
                 .limit(3)
    @total_polls = Poll.where(meal_id: @meal.id).count

    if @endtime == nil
      return
    elsif Time.now < @endtime && @endtime != nil
      # @fortune = fortune
      @time_left = get_time_left
    end

    # Remove duplicates of users
    # Collect preferences of each user
    all_prefs = @meal.users.uniq.flat_map(&:preferences)
    # Remove duplicates of preferences
    @collated_prefs = all_prefs.uniq

    @restaurants = []
    @polls.each do |poll|
      cuisine = poll.cuisine.name
      results = first_api_call(@meal.latitude, @meal.longitude, cuisine)
      results_json = JSON.parse(results.results)
      restaurant_info(results_json, cuisine).each { |resto| @restaurants << resto }
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

  def first_api_call(lat, long, cuisine)
    verdict = Verdict.where(lat: lat, long: long, cuisine: cuisine).first
    if verdict.nil?
      url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{long}&radius=2000&types=restaurant&keyword=#{cuisine}&key=#{ENV['GOOGLE_PLACES_API']}"
      response = RestClient.get url
      repos = JSON.parse(response)
      verdict = Verdict.create(lat: lat, long: long, cuisine: cuisine, results: JSON.generate(repos))
    end
    return verdict
  end

  def restaurant_info(json, cuisine)
    results = json["results"]
    restaurants = results.slice(0, 2).map do |resto|
      restaurant = second_api_call(resto["place_id"], cuisine)
    end
  end

  def second_api_call(place_id, cuisine)
    url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{place_id}&fields=name,vicinity,rating,website,formatted_phone_number,url&key=#{ENV['GOOGLE_PLACES_API']}"
    restaurant = Restaurant.find_by(place_id: place_id)
    if restaurant.nil?
      response = RestClient.get url
      repos = JSON.parse(response)["result"]
      restaurant = Restaurant.create(name: repos["name"],
                                     vicinity: repos["vicinity"],
                                     rating: repos["rating"],
                                     website: repos["website"],
                                     formatted_phone_number: repos["formatted_phone_number"],
                                     url: repos["url"],
                                     place_id: place_id,
                                     cuisine_id: Cuisine.find_by(name: cuisine).id)
    end
    return restaurant
  end
end
