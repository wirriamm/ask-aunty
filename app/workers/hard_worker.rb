class HardWorker
  include Sidekiq::Worker

  def perform()
    p 'Worker started!'
    @meals = Meal.where("is_notified = 'false'").joins(:polls).select("meals.id, pax, count(polls) as polls_count").group("meals.id").having("count(polls) = pax * 10")
    send_email(@meals, true)
    @ended_meals = Meal.where("endtime < ? AND is_notified = 'false'", Time.now)
    send_email(@ended_meals, false)
    p 'Finished!'
  end

  private

  def send_email(meals, all_pax_completed)
    meals.each do |meal|
      meal = Meal.find(meal.id)
      @users = meal.users
      @users.each do |user|
        if all_pax_completed
          UserMailer.all_pax_completed_email(user.email, meal.vanity_id).deliver_later
          p "Sent email to notify user #{user.email} that all pax in meal #{meal.vanity_id} have completed the polls!"
        else
          UserMailer.endtime_is_over_email(user.email, meal.vanity_id).deliver_later
          p "Sent email to notify user #{user.email} that the meal #{meal.vanity_id} has ended!"
        end
      end
      meal.is_notified = true
      meal.save
    end
  end
end
