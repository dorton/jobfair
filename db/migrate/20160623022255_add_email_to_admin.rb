class AddEmailToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :email_option, :boolean, :default => false
  end
end
