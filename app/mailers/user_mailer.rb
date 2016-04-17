class UserMailer < ApplicationMailer
  def admin_email(user)
    @user = user
    @url  = 'http://example.com/login'
    @events = Event.where("date = ?", Date.today)
    mail(to: @user.email, subject: "TIY Houston Event Attendees")
  end
end
