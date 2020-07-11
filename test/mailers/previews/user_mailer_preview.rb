# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/push_email
  def push_email
    user = User.first
    UserMailer.push_email(user)
  end

end
