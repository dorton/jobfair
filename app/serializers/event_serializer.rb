class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :date
  has_many :users
end
