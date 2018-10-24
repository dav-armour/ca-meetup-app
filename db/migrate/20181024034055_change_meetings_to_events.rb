class ChangeMeetingsToEvents < ActiveRecord::Migration[5.2]
  def change
    rename_table :meetings, :events
  end
end
