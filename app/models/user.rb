class User < ActiveRecord::Base
	validates_presence_of :email, :name, :interest
	validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  # validates_uniqueness_of :email

	has_many :user_events

	has_many :events, through: :user_events
	has_many :locations, through: :userlocations, dependent: :destroy
	has_many :userlocations, dependent: :destroy



	def event_count
	  self.events.count
	end

	def crash_course_campaign
	  if self.interest == 'I am interested in possibly becoming a student.' && self.event_count == 1
			"Possible_Student_1"
		elsif self.interest == 'I am interested in possibly becoming a student.' && self.event_count > 1
			"Possible_Student_2"
		elsif self.interest == 'I am interested in learning more about The Iron Yard.' && self.event_count == 1
			"RFI_TIY1"
		elsif self.interest == 'I am interested in learning more about The Iron Yard.' && self.event_count  > 1
			"RFI_TIY2"
		elsif self.interest == "I'm just here for the free learnin\'."
			"FREE_LEARNIN"
		else
			"ATTENDED_CRASH_COURSE"
		end
	end

	default_scope -> { order(interest: :asc) }


	def self.to_csv
    attributes = %w{email last_name first_name interest event_count crash_course_campaign}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end


end
