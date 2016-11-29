class AddSubjectToEvent < ActiveRecord::Migration
  def change
    add_column :events, :subject, :string
  end
end
