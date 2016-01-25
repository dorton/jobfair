class AddAssestsToUser < ActiveRecord::Migration
  def change
    add_column :users, :employment_name, :string
    add_column :users, :twitter_handle, :string
    add_column :users, :twitter_id, :string
    add_column :users, :linkedin_handle, :string
    add_column :users, :employment_domain, :string
    add_column :users, :fuzzy, :boolean

  end
end
