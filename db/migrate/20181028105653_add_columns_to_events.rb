class AddColumnsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :description, :text
    add_column :events, :last_updated, :datetime
  end
end
