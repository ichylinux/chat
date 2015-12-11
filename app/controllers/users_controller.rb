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

  def destroy
    room = Room.find(params[:room_id])
    user = RoomUser.find_by(room_id: room.id, name: params[:id])
    if user
      user.destroy
      render json: {result: true}
    else
      render json: {result: false, error: "User is not found!!"}
    end
  rescue ActiveRecord::RecordNotFound
    render json: {result: false, error: "Room or User is not found!!"}
  rescue ActiveRecord::RecordInvalid => err
    render json: {result: false, error: err.message}
  end

end
