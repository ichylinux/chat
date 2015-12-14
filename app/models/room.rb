class Room < ActiveRecord::Base
  validates :name, :presence => true

  has_many :users
  has_many :room_logs
end
