class AddFieldsToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :address, :string
    add_column :locations, :phone, :string
    add_column :locations, :url, :string
    add_column :locations, :meetup, :string
  end
end
