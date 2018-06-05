class Updateyeartoactiveuser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :year, :boolean
    rename_column :users, :year, :active
  end
end
