class CreateLocationevents < ActiveRecord::Migration
  def change
    create_table :locationevents do |t|
      t.references :location, index: true
      t.references :event, index: true

      t.timestamps null: false
    end
    add_foreign_key :locationevents, :locations
    add_foreign_key :locationevents, :events
  end
end
