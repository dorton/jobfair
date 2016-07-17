class UserMailer < ApplicationMailer
  def admin_email(admin)
    @admin = admin
    @events = Event.where("date = ?", Date.today)

    @events.each do |event|
      users = event.users.order(:interest)
      attachments["#{event.name.parameterize}.csv"] = {data: Base64.encode64(users.to_csv), encoding: 'base64' }
    end

    mail(to: @admin.email, subject: "TIY Houston Event Attendees")
  end
end
