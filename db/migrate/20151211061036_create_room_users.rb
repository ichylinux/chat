class CreateRoomUsers < ActiveRecord::Migration
  def change
    create_table :room_users do |t|
      t.integer :room_id, :null => false
      t.string :name, :null => false

      t.timestamps null: false
    end
  end
end
