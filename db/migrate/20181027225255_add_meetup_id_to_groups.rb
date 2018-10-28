class AddMeetupIdToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :meetup_id, :integer
  end
end
