module SessionsHelper

  def current_user
    return nil if session[:session_token].nil?
    @current_user || User.find(Session.find_by_session_token(session[:session_token]).user_id)
  end

  def current_user=(user)
    session[:session_token] = user.reset_session_token! #this inserts into sessions db
    @current_user = user
  end

end
