class UsersController < ApplicationController
  before_filter :not_logged_in?, only: [:new]

  def new
    render :new
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

  def show
    @user = User.find_by_username(params[:username])
    if !!@user
      render :show
    else
      redirect_to not_found_url
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
