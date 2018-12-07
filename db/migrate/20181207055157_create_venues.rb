class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      t.references :event, foreign_key: true
      t.string :name
      t.float :lat
      t.float :lon
      t.string :address
      t.string :city

      t.timestamps
    end
  end
end
