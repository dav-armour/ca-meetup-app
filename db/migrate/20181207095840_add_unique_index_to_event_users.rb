class AddUniqueIndexToEventUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :event_users, [ :event_id, :user_id ], :unique => true, :name => 'by_event_and_user'
  end
end
