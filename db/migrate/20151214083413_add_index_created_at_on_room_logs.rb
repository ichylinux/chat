class AddIndexCreatedAtOnRoomLogs < ActiveRecord::Migration
  def change
    add_index :room_logs, :created_at
  end
end
