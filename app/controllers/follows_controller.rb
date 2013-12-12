class FollowsController < ApplicationController

  def create
    params[:follow][:follower_id] = current_user.id
    follow = Follow.new(params[:follow])
    if follow.save
      redirect_to page_show_url(User.find(params[:follow][:followee_id]).username)
    else
      flash[:error] = "follow unsucessful :("
      redirect_to root_url
    end
  end

  def destroy
    follow = Follow.find_by_follower_id_and_followee_id(current_user.id, params[:id])
    follow.destroy
    redirect_to page_show_url(User.find(params[:id]).username)
  end

  def update
    #sort priority changes
  end

end
