class AddHtmlClassToMeeting < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :html_class, :string
  end
end
