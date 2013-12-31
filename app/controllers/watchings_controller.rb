class WatchingsController < ApplicationController

  def create

    watching = Watching.find_by_user_id(current_user.id) if !!current_user
    unless !!watching
      watching = Watching.new()
    end
    render json: "success!"
  end

  def destroy

  end

end
