class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.push_email.subject
  #
  def endtime_is_over_email(email)
    mail(to: email, subject: "Endtime is over!")
  end

  def all_pax_completed_email(email)
    mail(to: email, subject: "All pax completed!")
  end
end
