class UserMailer < ApplicationMailer
  default from: "Event Mailer <noreply@theironyard.com>",
          reply_to: "noreply@theironyard.com"
  def admin_email(admin)
    @admin = admin
    @admin_location = admin.locations.last
    @events = Event.where("date = ?", Date.today).joins(:locations).where("locations.id = ?", @admin_location)
    @events.map do |event|
      if event.event_type == "Open House"
        attachments.inline['header.png'] = File.read("app/assets/images/openhouse.png")
      elsif event.event_type == "Crash Course" && event.subject == "JS"
        attachments.inline['header.png'] = File.read("app/assets/images/js.png")
      elsif event.event_type == "Crash Course" && event.subject == ".NET"
        attachments.inline['header.png'] = File.read("app/assets/images/dotnet.jpg")
      elsif event.event_type == "Crash Course" && event.subject == "iOS"
        attachments.inline['header.png'] = File.read("app/assets/images/dotnet.jpg")
      else
        attachments.inline['header.png'] = File.read("app/assets/images/TIY-logo.png")
      end
    end
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
    @location = @admin.locations.first

      if @event.event_type == "Open House"
        attachments.inline['header.png'] = File.read("app/assets/images/openhouse.png")
      elsif @event.event_type == "Crash Course" && event.subject == "JS"
        attachments.inline['header.png'] = File.read("app/assets/images/js.png")
      elsif @event.event_type == "Crash Course" && event.subject == ".NET"
        attachments.inline['header.png'] = File.read("app/assets/images/dotnet.jpg")
      elsif @event.event_type == "Crash Course" && event.subject == "iOS"
        attachments.inline['header.png'] = File.read("app/assets/images/dotnet.jpg")
      else
        attachments.inline['header.png'] = File.read("app/assets/images/TIY-logo.png")
      end

    
    mail(to: @user.email,
         reply_to: @admin.email,
         subject: "Welcome to the #{@event.name} @TheIronYard!")
  end
end
