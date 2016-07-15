class Location < ActiveRecord::Base
  has_many :admins, through: :locationadmins, dependent: :destroy
  has_many :locationadmins
  has_many :events, through: :locationevents, dependent: :destroy
  has_many :locationevents
  has_many :users, through: :userlocations, dependent: :destroy
  has_many :userlocations

  def name
    "#{city}"
  end
end
