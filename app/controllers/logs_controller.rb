class LogsController < ApplicationController

  def index
    render :json => RoomLog.all
  end

  def create
    r = Room.find(params[:room_id])
    rl = r.room_logs.build(room_log_params)
    rl.save!

    render :nothing => true, :status => :created
  end

  private

  def room_log_params
    {
      :name => params[:name],
      :message => params[:message]
    }
  end

end
