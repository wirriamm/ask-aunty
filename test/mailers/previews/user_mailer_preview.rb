# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/push_email
  def endtime_is_over_email(email)
    mail(to: email, subject: "Endtime is over!")
  end

  def all_pax_completed_email(email)
    mail(to: email, subject: "All pax completed!")
  end
end
