class PagesController < ApplicationController

  def show
    if params[:demo]
      user = User.find_by_username("user3")
      self.current_user=(user)
    end
    @user = User.find_by_username(params[:username])
    if !!@user
      @follows = current_user.follows if !!current_user
      @page = Page.find_by_user_id(@user.id)
      @containers = Container.find_all_by_page_id(@page.id)
      render :show
    else
      redirect_to not_found_url
    end
  end

  def edit
    @user = current_user
    user = User.find_by_username(params[:username])
    if !!@user && !!user && @user.username == user.username
      @page = Page.find_by_user_id(@user.id)
      @containers = Container.find_all_by_page_id(@page.id)
      render :edit
    else
      flash[:error] = "You must be logged in as the owner of this page to edit it"
      redirect_to root_url
    end
  end

  def update
    @user = current_user
    user = User.find(Page.find(params[:id]).user_id)
    if !!@user && !!user && @user.username == user.username
      @page = Page.find_by_user_id(@user.id)
      #params[:page].values.map{|x| nil if x == ""}
      @page.update_attributes(params[:page])
      @containers = Container.find_all_by_page_id(@page.id)
      @containers.each_with_index do |container, i|
        container.update_attributes(params[:container][i.to_s])
      end

      #new containers!!
      if !!params[:container]
        params[:container].keys.select{|x| /key/.match(x) }.each do |new_container_key|
          if !params[:container][new_container_key].values.none?{ |x| x != "" }
            params[:container][new_container_key][:page_id] = @page.id
            new_container = Container.create!(params[:container][new_container_key])
          end
        end
      end

      redirect_to page_show_url(@user.username)
    else
      flash[:error] = "You must be logged in as the owner of this page to edit it"
      redirect_to root_url
    end
  end
end
