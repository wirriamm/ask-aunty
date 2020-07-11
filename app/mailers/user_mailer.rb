class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.push_email.subject
  #
  def push_email(user)
    @user = user
    mail(to: @user.email, subject: "The result of you meal is here!")
  end

  private

  def endtime_is_over

  end
end
