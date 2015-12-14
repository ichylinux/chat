class CreateRoomLogs < ActiveRecord::Migration
  def change
    create_table :room_logs do |t|
      t.integer :room_id, :null => false
      t.string :name, :null => false
      t.string :topic, :null => false
      t.text :message

      t.timestamps null: false
    end
  end
end
