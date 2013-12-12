class StaticPagesController < ApplicationController

  #before_filter :logged_in?

  def index
    #to revert just copy from def logged_in? starting at if !!params... to its end
  end

  def not_found
    render :no
  end

  def logged_in?
    if !current_user
      if !!params[:code]
        url = "https://api.twitch.tv/kraken/oauth2/token.json"
        @result = RestClient.post(url,{
          client_id: "",
          client_secret: "",
          grant_type: "authorization_code",
          redirect_uri: "http://localhost:3000/",
          code: params[:code]
          }
        )

        @access_token = JSON.parse(@result)["access_token"]
        user = get_user_from_token
        #render :index
      else
        #this has the scope!
        scope = "user_read"
        client_id = fail #change this after interpolating this into the string below
        url = "https://api.twitch.tv/kraken/oauth2/authorize?response_type=code&client_id=#{}&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2F&scope=#{scope}"
        redirect_to url
      end
    end
  end

  def get_user_from_token
    t_user = JSON.parse(RestClient.get("https://api.twitch.tv/kraken/user?oauth_token=#{@access_token}"))
    user = User.find_by_username(t_user["display_name"])
    if user.nil?

    else

    end
  end

end
