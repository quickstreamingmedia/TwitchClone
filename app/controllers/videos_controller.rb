class VideosController < ApplicationController

  def index
    @user = User.find_by_username(params[:username])
    if !!@user
      @videos = @user.videos
      @test = self.update_videos
      # @videos = Video.find_all_by_user_id(@user.id)
      render :index
    else
      redirect_to not_found_url
    end
  end

  def update_videos
    begin #{@user.username}
      @test = RestClient.get("https://api.twitch.tv/kraken/channels/#{@user.username}/videos?limit=10")
    rescue
      @test = nil
    end
    videos_array = (!!@test) ? JSON.parse(@test)["videos"] : []
    videos_array.reverse.each do |video|
      if !!@videos.find{ |x| x.cid == video["_id"] }

      else
        Video.create!(
        user_id: @user.id,
        thumbnail_url: video["preview"],
        title: video["title"],
        description: video["description"],
        video_url: video["url"],
        game_title: video["game"],
        cid: video["_id"]
        )
      end
    end

    videos_array
  end

  def show
    if params[:demo]
      user = User.find_by_username("user3")
      self.current_user=(user)
    end
    @video = Video.find_by_id(params[:id])
    if !!@video
      @comments = Comment.find_all_by_video_id(@video.id)
      @comments_by_parent_id = @video.comments_by_parent_id
      @user = User.find(@video.user_id)
      @page = @user.page
      @videos = @user.videos
      @test = self.update_videos

      @containers = @user.page.containers

      @videos = @user.videos
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
