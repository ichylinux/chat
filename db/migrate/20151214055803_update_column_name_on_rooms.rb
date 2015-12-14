class UpdateColumnNameOnRooms < ActiveRecord::Migration
  def up
    change_column :rooms, :name, :string, :null => false
  end

  def down
    change_column :rooms, :name, :string, :null => true
  end
end
