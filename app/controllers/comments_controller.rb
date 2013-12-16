class CommentsController < ApplicationController

  def create
    #params[:comment][:video_id] = params[:video_id]
    #params[:comment][:user_id] = current_user.id
    #comment = Comment.new(params[:comment])

    comment = Comment.new(
      parent_id: params[:parent_id],
      user_id: current_user.id,
      video_id: params[:video_id],
      body: params[:body]
    )
    comment.save!
    render :json => comment

    # if comment.save
#       redirect_to video_url(params[:video_id])
#     else
#       flash[:error] = "Comment could not be posted"
#       redirect_to video_url(params[:video_id])
#     end
  end

  def update
    comment = Comment.find(params[:id])
    #NEED TO VALIDATE HERE THAT DELETER IS EITHER
    #a) THE COMMENT OWNER, b) A PAGE MOD, or c) THE PAGE OWNER
    if !!params[:comment]

    else
      comment.update_attribute(:body, "[deleted]")
      redirect_to video_url(comment.video_id)
    end
  end

end
