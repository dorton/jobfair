# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

def create_location
  Location.create([{city: 'Houston'}, {city: 'Austin'}, {city: 'San Antonio'}, {city: 'Dallas'}, {city: 'Salt Lake City'}, {city: 'Las Vegas'}])
end

create_location

def create_admin
  houston = Admin.create!(email: 'brian.dorton@theironyard.com', password: '12345678', first_name: "Brian", last_name: "Dorton", super_admin: true, rails_admin: true)
  austin = Admin.create!(email: 'karly@theironyard.com', password: '12345678', first_name: "Karly", last_name: "Bordon")
  san_antonio = Admin.create!(email: 'hanh@theironyard.com', password: '12345678', first_name: "Hanh", last_name: "Nguyen")
  dallas = Admin.create!(email: 'caitlin@theironyard.com', password: '12345678', first_name: "Caitlin", last_name: "Studley")
  salt_lake = Admin.create!(email: 'garrett@theironyard.com', password: '12345678', first_name: "Garrett", last_name: "Clark")
  vegas = Admin.create!(email: 'gabe@theironyard.com', password: '12345678', first_name: "Gabe", last_name: "Shepherd")
  vegas = Admin.create!(email: 'christie@theironyard.com', password: '12345678', first_name: "Christie", last_name: "Loyd")
  global = Admin.create!(email: 'shawn@theironyard.com', password: '12345678', first_name: "Shawn", last_name: "Spainhour", super_admin: true)
  houston.locations << Location.where(city: "Houston")
  austin.locations << Location.where(city: "Austin")
  san_antonio.locations << Location.where(city: "San Antonio")
  dallas.locations << Location.where(city: "Dallas")
  salt_lake.locations << Location.where(city: "Salt Lake City")
  vegas.locations << Location.where(city: "Las Vegas")
end

create_admin

def create_event
  campus = Location.first
  event = Event.new
  event.name = [Faker::Hacker.adjective, Faker::Hacker.noun].join(" ").titleize
  event.date = Faker::Date.backward(240)
  event.event_type = ['Crash Course', 'Open House', 'Demo Day', 'Presentation Day'].sample
  event.locations << campus
  event.save!
  event
end


29.times do
  create_event
end

def create_user
  user = User.new
  user.name = Faker::Name.name
  user.email = Faker::Internet.email
  user.interest = ['I am interested in possibly becoming a student.', 'I am interested in learning more about The Iron Yard.', "I'm just here for the free learnin\'."].sample
  first_name = user.name.split(" ").first
  last_name = user.name.split(" ").last
  user.update_attributes(first_name: first_name, last_name: last_name)
  user.save
  user
end

50.times do
  user = create_user
  location = Location.first
  user.locations << location
  [1,1,1,1,1,2,2,2,2,3,3,3,4,4,5].sample.times do
    event = Event.joins(:locations).where("locations.id = ?", location).all.sample
    user.events << event unless user.events.include?(event)
  end
end

# def create_admin
#   user = Admin.new
#   user.last_name = 'Dorton'
#   user.first_name = 'Brian'
#   user.email = 'brian.dorton@theironyard.com'
#   user.password = '12345678'
#   user.save!
#   user
# end
#
# create_admin
