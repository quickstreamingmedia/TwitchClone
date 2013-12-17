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
    @comment = Comment.find(params[:id])
    @video = Video.find(params[:video_id])
    mods = Page.find(@video.user_id).moderators
    if !!current_user && (current_user.id == @video.user_id || current_user.id == @comment.user_id || mods.include?(current_user))
      #NEED TO VALIDATE THAT THE COMMENT BEING DELTED DOES NOT BELONG TO THE PAGE OWNER
      #MODERATORS SHOULD NOT BE ABLE TO DELETE THE COMMENTS OF OTHER MODERATORS
      if (@comment.user_id == @video.user_id && current_user.id != @video.user_id) ||
        (!mods.none?{ |x| x.id == @comment.user_id } && current_user.id != @video.user_id)

      else
        @comment.update_attribute(:body, "[deleted]")
        render json: @comment
        #redirect_to video_url(comment.video_id)
      end
    else
      render json: nil
    end
  end

end
