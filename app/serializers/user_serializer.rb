class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :note, :event


  def event
    object.event
  end


end
