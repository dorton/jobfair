# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

def create_event
  event = Event.new
  event.name = Faker::Company.bs.titleize
  event.date = Faker::Date.backward(240)
  event.location = 'The Iron Yard'
  event.save
  event
end


13.times do
  create_event
end

def create_user
  user = User.new
  user.name = Faker::Name.name
  user.email = Faker::Internet.email
  user.interest = ['Interested in becomming a student', 'Interested in learning more about tiy', 'Just here for the free food/learning'].sample
  user.save
  user
end

150.times do
  user = create_user
  [1,1,1,1,2,3,4].sample.times do
    sample = Event.all.sample
    user.events << sample unless user.events.include?(sample)
  end
end

def create_admin
  user = Admin.new
  user.last_name = 'Dorton'
  user.first_name = 'Brian'
  user.email = 'brian.dorton@theironyard.com'
  user.password = '12345678'
  user.save!
  user
end

create_admin
