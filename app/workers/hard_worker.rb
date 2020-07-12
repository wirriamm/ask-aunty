class HardWorker
  include Sidekiq::Worker

  def perform()
    p 'Worker started!'
    @meals = Meal.where("endtime < ? AND is_notified = 'false'", Time.now)
                 .or(Meal.joins(:polls).select("meals.id, pax, count(polls) as polls_count").group("meals.id").having("count(polls) = pax * 10"))
    @meals.each do |meal|
      @users = meal.users
      @users.each do |user|
        p "Meal #{meal.vanity_id}, user #{user.email}"
        UserMailer.push_email("ngandth.1992@gmail.com").deliver_later
      end
      meal.is_notified = true
      meal.save
    end
    @completed_meals = Meal.joins()
    p 'Finished!'
  end
end
