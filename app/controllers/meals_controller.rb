class MealsController < ApplicationController
  def new
    @meal = Meal.new
    respond_to do |format|
      format.html
      format.json { render json: { meal: params[:meal][:vanity_id] } }
    end
  end

  def create
    @meal = Meal.new(
      vanity_id: generate_vanity_id,
      endtime: Time.now + 2 * 60 * 60,
      postal_code: params[:meal][:postal_code]
      )
    if @meal.save
      respond_to do |format|
        format.html
        format.json { render json: { meal: @meal } }
      end
      # change to preferences path
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
      @poll = Poll.new(cuisine: cuisine, meal: @meal, user: current_user)
      @polls << @poll
    end
  end

  def result
  end

  private

  def generate_vanity_id
    loop do
      random_code = SecureRandom.alphanumeric
      return random_code if Meal.find_by(vanity_id: random_code).nil?
    end
  end
end
