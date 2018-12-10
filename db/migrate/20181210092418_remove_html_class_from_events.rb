class RemoveHtmlClassFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :html_class, :string
  end
end
