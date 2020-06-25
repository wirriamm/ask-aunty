class MealsController < ApplicationController
  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(
      vanity_id: generate_vanity_id,
      endtime: Time.now + 2 * 60 * 60,
      postal_code: params[:meal][:postal_code]
      )
    if @meal.save
      redirect_to preferences_path
    else
      render :new
    end
  end

  def show
  end

  def setup
    @cuisines = Cuisine.all
    @polls = []
    @meal = Meal.find(params[:id])
    @cuisines.each do |cuisine|
      @poll = Poll.new(cuisine: cuisine)
      @polls << @poll
    end
  end

  def result
  end

  private

  def generate_vanity_id
    loop do
      random_code = SecureRandom.alphanumeric(6)
      return random_code if Meal.find_by(vanity_id: random_code).nil?
    end
  end
end
