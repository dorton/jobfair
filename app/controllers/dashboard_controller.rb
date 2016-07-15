class DashboardController < ApplicationController

  def index
    if current_admin.super_admin?
      @user = User.all
    else
      @user = User.joins(:locations).where("locations.id = ?", current_admin.locations.last)
    end

    if current_admin.super_admin?
      @event = Event.all
    else
      @event = Event.joins(:locations).where("locations.id = ?", current_admin.locations.last)
    end

    @unique = @user.all.count

                 # SELECT "user_events".* FROM "user_events" GROUP BY user_id HAVING count(*) > 1
    @repeaters = @user.joins(:events).group("users.id").having("count(users.id) > 1").to_a.count

    @repeaters_percent = (@repeaters.to_f / @unique.to_f) * 100

    @firsttimers = @user.joins(:events).group("users.id").having("count(users.id) = 1").to_a.count

    @firsttimers_percent = (@firsttimers.to_f / @unique.to_f) * 100

    @event_totals = @event.count

    @crash_course_count = @event.where("events.name LIKE ?", "%Crash Course%").count

    @demoday_count = @event.where("events.name LIKE ?", "%Demo Day%").count

    @crash_courses_goers = @user.joins(:user_events => :event).where("events.name LIKE ?", "%Crash Course%").count

    @demo_day_goers = @user.joins(:user_events => :event).where("events.name LIKE ?", "%Demo Day%").count

    @interests = @user.pluck('DISTINCT interest').reject(&:blank?)

    @event_names = @event.pluck('DISTINCT name')

    @students = @user.where(student: true)

    @conversion_avg = (@students.count.to_f / @unique.to_f) * 100

    @student_event_avg = (@user.where(student: true).joins(:events).to_a.count.to_f) / @user.where(student: true).count.to_f

    @rand_color = ["#b87333", "silver", "gold", "red", "blue"].sample

    @top_ten = @user.joins(:events).group("users.id").order("count(users.id) DESC").first(10)



  end
end
