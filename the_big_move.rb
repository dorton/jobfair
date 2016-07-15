def create_location
  Location.create([{city: 'Houston'}, {city: 'Austin'}, {city: 'San Antonio'}, {city: 'Dallas'}, {city: 'Salt Lake City'}, {city: 'Las Vegas'}])
end

create_location

def create_admin
  houston = Admin.create!(email: 'brian.dorton@theironyard.com', password: '12345678', first_name: "Brian", last_name: "Dorton")
  austin = Admin.create!(email: 'karly@theironyard.com', password: '12345678', first_name: "Karly", last_name: "Bordon")
  san_antonio = Admin.create!(email: 'hanh@theironyard.com', password: '12345678', first_name: "Hanh", last_name: "Nguyen")
  dallas = Admin.create!(email: 'caitlin@theironyard.com', password: '12345678', first_name: "Caitlin", last_name: "Studley")
  salt_lake = Admin.create!(email: 'garrett@theironyard.com', password: '12345678', first_name: "Garrett", last_name: "Clark")
  vegas = Admin.create!(email: 'gabe@theironyard.com', password: '12345678', first_name: "Gabe", last_name: "Shepherd")
  houston.locations << Location.where(city: "Houston")
  austin.locations << Location.where(city: "Austin")
  san_antonio.locations << Location.where(city: "San Antonio")
  dallas.locations << Location.where(city: "Dallas")
  salt_lake.locations << Location.where(city: "Salt Lake City")
  vegas.locations << Location.where(city: "Las Vegas")
end

create_admin

# Add Events to Houston Location
campus = Location.where(city: "Houston")
event = Event.all
event.locations << campus


# Add users to Houston Location
user = User.all
location = Location.all.sample
user.locations << Location.where(city: "Houston")
