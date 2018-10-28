class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :urlname
      t.text :description
      t.integer :location
      t.string :link

      t.timestamps
    end
  end
end
