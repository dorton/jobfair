# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def entry_mailer
    admin = Admin.first
    event = Event.last
    user = User.last

    UserMailer.entry_email(user, event, admin)
  end
end
