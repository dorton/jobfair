class UserMailer < ApplicationMailer
  default from: "Event Mailer <noreply@theironyard.com>",
          reply_to: "noreply@theironyard.com"
  def admin_email(admin)
    @admin = admin
    @admin_location = admin.locations.last
    @events = Event.where("date = ?", Date.today).joins(:locations).where("locations.id = ?", @admin_location)

    Location.joins(:events).where("events.date = ?", Date.today).joins(:admins).where("admins.id = ?", @admin).uniq.map do |location|
        location.events.where("events.date = ?", Date.today).map do |event|
        users = event.users.order(:interest)
        attachments["#{event.name.parameterize}.csv"] = {data: Base64.encode64(users.to_csv), encoding: 'base64' }
      end
    end
    mail(to: @admin.email, subject: "TIY #{@admin.locations.first.city} Event Attendees")
  end

  def entry_email(user, event, admin)
    @user = user
    @event = event
    @admin = admin
    mail(to: @user.email,
         reply_to: @admin.email,
         subject: "Welcome to the #{@event.name} @TheIronYard!")
  end
end
