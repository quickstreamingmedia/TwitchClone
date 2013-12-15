class FollowsController < ApplicationController
  before_filter :setup_follows_and_followers


  def setup_follows_and_followers
    if !!current_user
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

  def create
    follow = Follow.new(followee_id: params[:followee_id], follower_id: current_user.id)
    follow.save!
    @user = User.find(params[:followee_id])
    render :json => @user
    # if follow.save
#       redirect_to page_show_url(User.find(params[:follow][:followee_id]).username)
#     else
#       flash[:error] = "follow unsucessful :("
#       redirect_to root_url
#     end
  end

  def destroy
    follow = Follow.find_by_follower_id_and_followee_id(current_user.id, params[:id])
    follow.destroy
    render :json => nil
    # redirect_to page_show_url(User.find(params[:id]).username)
  end

  def update
    #sort priority changes
  end

end
