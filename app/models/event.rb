class Event < ActiveRecord::Base

  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events
  has_many :locations, through: :locationevents
  has_many :locationevents, dependent: :destroy
  belongs_to :admin
  validates_presence_of :date, :name

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
