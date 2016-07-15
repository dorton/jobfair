class CreateLocationadmins < ActiveRecord::Migration
  def change
    create_table :locationadmins do |t|
      t.references :location, index: true
      t.references :admin, index: true

      t.timestamps null: false
    end
    add_foreign_key :locationadmins, :locations
    add_foreign_key :locationadmins, :admins
  end
end
