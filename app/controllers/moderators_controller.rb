class ModeratorsController < ApplicationController
  before_filter :is_page_owner?

  def create
    mod = Moderator.new(page_id: params[:page_id], user_id: params[:user_id])
    mod.save!
    render :json => mod
  end

  def destroy
    mod = Moderator.find_by_page_id_and_user_id(params[:page_id], params[:user_id])
    mod.destroy
    render :json => nil
  end

  def is_page_owner?
    if !!current_user && Page.find(current_user.id).id == params[:page_id]
      redirect_to root_url
    end
  end
end
