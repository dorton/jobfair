class AddsEventToUser < ActiveRecord::Migration
  def change
    add_column :users, :event_id, :integer
    remove_column :users, :event, :string
    add_column :events, :name, :string
    add_column :events, :location, :string
    add_column :events, :date, :date
  end
end
