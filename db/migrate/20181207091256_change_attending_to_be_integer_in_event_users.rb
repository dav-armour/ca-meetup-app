class ChangeAttendingToBeIntegerInEventUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :event_users, :attending, :integer, :using => 'case when attending then 1 else 0 end'
  end

  def down
    change_column :event_users, :attending, :boolean, :using => 'case when attending = 1 then true else false end'
  end
end
