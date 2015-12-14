class UsersController < ApplicationController

  def index
    room = Room.find(params[:room_id])
    users = RoomUser.where(room_id: room.id).all
    users_json = users.map{|user| {id: user.id, name: user.name, login_at: user.created_at} }
    render json: {result: true, users: users_json}
  rescue ActiveRecord::RecordNotFound
    render json: {result: false, error: "Room is not found!!"}
  end

  def create
    room = Room.find(params[:room_id])
    user = RoomUser.new(room_id: room.id, name: params[:name])
    user.save!

    if Rails.env.production?
      Magellan::Publisher.publish("worker/rooms/#{room.id}", "#{user.name} has entered this room.")
    end

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

      if Rails.env.production?
        Magellan::Publisher.publish("worker/rooms/#{room.id}", "#{user.name} has exit.")
      end

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
