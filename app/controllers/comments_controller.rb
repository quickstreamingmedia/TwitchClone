class CommentsController < ApplicationController

  def create
    params[:comment][:video_id] = params[:video_id]
    params[:comment][:user_id] = current_user.id
    comment = Comment.new(params[:comment])
    if comment.save
      redirect_to video_url(params[:video_id])
    else
      flash[:error] = "Comment could not be posted"
      redirect_to video_url(params[:video_id])
    end
  end

end
