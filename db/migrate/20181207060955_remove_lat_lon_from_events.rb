class RemoveLatLonFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :lat, :float
    remove_column :events, :lon, :float
  end
end
