class AddStyleColumnsToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :background_colour, :string
    add_column :groups, :text_colour, :string
  end
end
