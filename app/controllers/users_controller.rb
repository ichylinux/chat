class UsersController < ApplicationController

  def create
    room = Room.find(params[:room_id])
    username = params[:name]
    user = RoomUser.new(room_id: room.id, name: username)
    user.save!
    render json: {result: true, id: user.id, name: user.name}
  rescue ActiveRecord::RecordNotFound
    render json: {result: false, error: "Room is not found!!"}
  rescue ActiveRecord::RecordInvalid => err
    render json: {result: false, error: err.message}
  end

end
