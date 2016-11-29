
# run this if you are having more than one event back to back. For instance, an open house just before a crash course.

def back_mailer
  users = Event.joins(:locations).where(locations: {city: "Houston"}).last(2).first.users
  admin = Admin.find(1)
  event = Event.joins(:locations).where(locations: {city: "Houston"}).last

  users.each do |user|
    UserMailer.entry_email(user, event, admin).deliver_now
    user.events << event
  end
end
