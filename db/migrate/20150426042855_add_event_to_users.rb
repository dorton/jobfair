class AddEventToUsers < ActiveRecord::Migration
  def change
    add_column :users, :event, :string
  end
end
