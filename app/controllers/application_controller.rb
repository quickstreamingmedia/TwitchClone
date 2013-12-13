class ApplicationController < ActionController::Base
  before_filter :setup_follows_and_followers


  include SessionsHelper
  protect_from_forgery

  def setup_follows_and_followers
    if !!current_user
      @user_follows = current_user.follows
      user_names = @user_follows.map{ |x| x.username }
      @streams_info = []
      user_names.each do |u_name|
        begin
          @streams_info << JSON.parse(RestClient.get("https://api.twitch.tv/kraken/streams/#{u_name}"))["stream"]
        rescue
        end
      end
      #@streams_info = JSON.parse(RestClient.get("https://api.twitch.tv/kraken/streams?channel=#{user_names.join('%2C')}"))

      @streams_info.each do |stream|
        next if stream.nil?
        if stream["channel"]
          live_user = @user_follows.find{ |x| x.username.downcase == stream["channel"]["display_name"].downcase }
          if !!live_user && live_user.status != "(LIVE)"
            live_user.update_attribute(:status, "(LIVE)")
          end
        end
      end

      @user_follows.each do |follow|
        if !@streams_info.find{|x| !x.nil? && x["channel"]["display_name"].downcase == follow.username.downcase }
          follow.update_attribute(:status, nil) if follow.status == "(LIVE)"
        end
      end

      @user_followers = current_user.followers
    end
  end
end
