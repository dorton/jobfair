class User < ActiveRecord::Base
	validates_presence_of :email, :name, :interest
	validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  # validates_uniqueness_of :email

	has_many :user_events

	has_many :events, through: :user_events
	has_many :locations, through: :userlocations, dependent: :destroy
	has_many :userlocations, dependent: :destroy

	def self.to_csv
    attributes = %w{email last_name first_name interest}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end


end
