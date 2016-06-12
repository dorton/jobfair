class DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
    @unique = User.all.count

                 # SELECT "user_events".* FROM "user_events" GROUP BY user_id HAVING count(*) > 1
    @repeaters = User.joins(:events).group("users.id").having("count(users.id) > 1").to_a.count

    @repeaters_percent = (@repeaters.to_f / @unique.to_f) * 100

    @firsttimers = User.joins(:events).group("users.id").having("count(users.id) = 1").to_a.count

    @firsttimers_percent = (@firsttimers.to_f / @unique.to_f) * 100

    @event_totals = Event.all.count

    @crash_course_count = Event.where("events.name LIKE ?", "%Crash Course%").count

    @demoday_count = Event.where("events.name LIKE ?", "%Demo Day%").count

    @crash_courses_goers = User.joins(:user_events => :event).where("events.name LIKE ?", "%Crash Course%").count

    @demo_day_goers = User.joins(:user_events => :event).where("events.name LIKE ?", "%Demo Day%").count

    @interests = User.pluck('DISTINCT interest').reject(&:blank?)

    @event_names = Event.pluck('DISTINCT name')

    @students = User.where(student: true)

    @conversion_avg = (@students.count.to_f / @unique.to_f) * 100

    @student_event_avg = (User.where(student: true).joins(:events).to_a.count.to_f) / User.where(student: true).count.to_f

    @rand_color = ["#b87333", "silver", "gold", "red", "blue"].sample



  end
end
