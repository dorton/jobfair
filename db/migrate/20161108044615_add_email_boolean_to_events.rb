class AddEmailBooleanToEvents < ActiveRecord::Migration
  def change
    add_column :events, :entryemailattendees, :boolean
  end
end
