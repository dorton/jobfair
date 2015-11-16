class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :company, :string
    add_column :users, :interest, :string
  end
end
