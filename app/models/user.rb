class User < ActiveRecord::Base
	validates_presence_of :email
	validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  # validates_uniqueness_of :email

	has_many :user_events

	has_many :events, through: :user_events



end
