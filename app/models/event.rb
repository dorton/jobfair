class Event < ActiveRecord::Base

  has_many :user_events
  has_many :users, through: :user_events
  belongs_to :admin
  validates_presence_of :date, :location, :name

  scope :student, -> { where(student: true)  }


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
