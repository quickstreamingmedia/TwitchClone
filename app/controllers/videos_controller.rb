class VideosController < ApplicationController

  def index
    @user = User.find_by_username(params[:username])
    if !!@user
      @videos = Video.find_all_by_user_id(@user.id)
      render :index
    else
      redirect_to not_found_url
    end
  end

  def show
    @video = Video.find_by_id(params[:id])
    if !!@video
      @comments = Comment.find_all_by_video_id(@video.id)
      @comments_by_parent_id = @video.comments_by_parent_id
      @videos = User.find(@video.user_id).videos
      render :show
    else
      redirect_to not_found_url
    end
  end

  def create
    params[:video][:user_id] = current_user.id
    @video = Video.new(params[:video])
    if @video.save
      redirect_to video_url(@video.id)
    else
      flash[:error] = @video.errors.full_messages
      redirect_to root_url
    end
  end

  def update
    @video = Video.find_by_id(params[:id])
    if !!@video
      @video.update_attributes(params[:video])
      redirect_to video_url(@video.id)
    else
      flash[:error] = "video could not be edited"
      redirect_to root_url
    end
  end

  def destroy

  end

end
