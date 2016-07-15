class CreateUserlocations < ActiveRecord::Migration
  def change
    create_table :userlocations do |t|
      t.references :user, index: true
      t.references :location, index: true

      t.timestamps null: false
    end
    add_foreign_key :userlocations, :users
    add_foreign_key :userlocations, :locations
  end
end
