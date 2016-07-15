class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable, :trackable, :validatable

   has_many :events
   has_many :locations, through: :locationadmins, dependent: :destroy
   has_many :locationadmins, dependent: :destroy

   def name
     "#{first_name} #{last_name}"
   end
end
