class UsersController < ApplicationController
  before_filter :not_logged_in?, only: [:new]
  #before_filter :setup_follows_and_followers, only: [:follows]

  def setup_follows_and_followers
    if !!current_user
      fail
      @user_follows = current_user.follows
      user_names = @user_follows.map{ |x| x.username.downcase }
      @streams_info = JSON.parse(RestClient.get("https://api.twitch.tv/kraken/streams?channel=#{user_names.join('%2C')}"))["streams"]

      @streams_info.each do |stream|
        next if stream.nil?
        if stream["channel"]
          live_user = @user_follows.find{ |x| x.username.downcase == stream["channel"]["display_name"].downcase }
          if !!live_user && live_user.status != "(LIVE)"
            live_user.update_attribute(:status, "(LIVE)")
          end
          if live_user.status == "(LIVE)"
            Page.find_by_user_id(live_user.id).update_attribute(:stream_title, stream["channel"]["status"])
          end
        end
      end

      @user_follows.each do |follow|
        if !@streams_info.find{|x| !x.nil? && x["channel"]["display_name"].downcase == follow.username.downcase }
          follow.update_attribute(:status, nil) if follow.status == "(LIVE)"
        end
      end

      @user_follows = @user_follows.select{ |x| x.status == "(LIVE)"} + @user_follows.reject{ |x| x.status == "(LIVE)"}

      @user_followers = current_user.followers
    end
  end

  def new
    render :new
  end

  def follows
    if !!current_user
      follows = current_user.get_follows
      render :json => follows #@user_follows
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      @user.active = true #this will change to email activation later!
      self.current_user=(@user)
      Page.create!(user_id: current_user.id, stream_title: "My Awesome Stream")
      redirect_to root_url
    else
      flash[:error] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def grab_videos
    @user = User.find_by_username(params[:username])
    @videos = @user.videos.page(params[:page]).per(3)
    render :show
  end

  def show
    @user = User.find_by_username(params[:username])
    if !!@user

      @videos = @user.videos.page(params[:page]).per(3)
      if !request.xhr?
        @follows = current_user.follows if !!current_user
        @page = Page.find_by_user_id(@user.id)
        @containers = Container.find_all_by_page_id(@page.id)
        render :show
      else
        #fail
        sleep(1.5)
        videos_partial = render_to_string(partial: "videos", locals: {
          videos: @videos})
        render text: videos_partial
      end
    else
      redirect_to not_found_url
    end
  end

  def stream
    if !!current_user && current_user.username == params[:username]
      @page = Page.find_by_user_id(current_user.id)
      render :stream
    else
      flash[:error] = "You do not have permission to be on that page"
      redirect_to root_url
    end
  end

  def edit
    @user = current_user
    user = User.find_by_username(params[:username])
    if !!@user && !!user && @user.username == user.username
      render :edit
    else
      flash[:error] = "You must be logged in as the owner of that page to edit that page"
      redirect_to root_url
    end
  end

  def update
    user = User.find(params[:id])
    @user = current_user
    if !!@user && !!user && @user.username == user.username
      @user.update_attributes(params[:user])
      redirect_to user_show_url(@user.username)
    else
      flash[:error] = "You must be logged in as the owner of that page to edit that page"
      redirect_to root_url
    end
  end

  def not_logged_in?
    if !!current_user
      redirect_to root_url
    end
  end

end
