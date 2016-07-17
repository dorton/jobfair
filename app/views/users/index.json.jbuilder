json.users @lastusers do |user|
  json.name user.name
  json.email user.email
  json.campus user.locations.first.name
    json.events user.events do |event|
      json.event_type event.event_type
      json.name event.name
      json.date event.date
      json.event_attendance event.users.count
    end
end
