class Locationadmin < ActiveRecord::Base
  belongs_to :location
  belongs_to :admin
end
