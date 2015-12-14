class RoomLogsController < ApplicationController

  def index
    render :json => RoomLog.all
  end

end
