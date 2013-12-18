class FollowsController < ApplicationController


  def create
    if !current_user || params[:followee_id] == current_user.id
      render :json => nil
    else
      follow = Follow.new(followee_id: params[:followee_id], follower_id: current_user.id)
      follow.save!
      @user = User.find(params[:followee_id])
      render :json => @user
    end
  end

  def destroy
    follow = Follow.find_by_follower_id_and_followee_id(current_user.id, params[:id])
    follow.destroy
    render :json => nil
    # redirect_to page_show_url(User.find(params[:id]).username)
  end

  def update
    #sort priority changes
    if !!current_user
      follow = Follow.find_by_follower_id_and_followee_id(current_user.id,params[:followee_id])
      follow.update_attribute(:sort_priority, params[:sort_priority])
      render json: "asdf"
    else
      render json: nil
    end
  end

end
