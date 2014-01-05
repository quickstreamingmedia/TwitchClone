class SessionsController < ApplicationController
  before_filter :not_logged_in?, only: [:new]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password]) if !!params[:user]
    if !!user
      self.current_user=(user)
      redirect_to root_url
    else
      flash[:error] = "Invalid credentials"
      redirect_to root_url
    end
  end

  def destroy
    Session.find_by_session_token(session[:session_token]).destroy
    session[:session_token] = nil
    redirect_to root_url
  end

  def not_logged_in?
    if !!current_user
      redirect_to root_url
    end
  end

end
