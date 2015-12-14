class LogsController < ApplicationController

  def index
    logs = RoomLog.where('created_at >= ? and created_at < ?', params[:datetime_from], params[:datetime_to])
    render :json => logs
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
