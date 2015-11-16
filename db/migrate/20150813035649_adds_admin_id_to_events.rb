class AddsAdminIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :admin_id, :integer
  end
end
