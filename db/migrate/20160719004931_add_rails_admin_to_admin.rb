class AddRailsAdminToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :rails_admin, :boolean
  end
end
