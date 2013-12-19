class ChatsController < ApplicationController

  def chat
    if !!current_user
      page_owner = User.find_by_username(params[:page_name])

      icon_objects = []
      icon_objects += ChatIcon.find_all_by_page_id(page_owner.page.id) if !!page_owner
      icon_objects += ChatIcon.find_all_by_page_specific(false)

      status_icons = ""
      if current_user.username == page_owner.username
        status_icons << "<img class=chat-status title='caster' width=20 height=20 src='http://c.dryicons.com/images/icon_sets/minimalistica_red_icons/png/128x128/camcorder.png' >"
      end

      if !!page_owner && page_owner.page.moderators.include?(current_user)
        status_icons << "<img class=chat-status title='moderator' width=20 height=20 src='http://upload.wikimedia.org/wikipedia/en/c/c0/Eyeofsauron.jpg' >"
      end

      chat_partial = render_to_string(partial: "partials/chats", locals: {
        body: params[:text],
        icon_objects: icon_objects,
        status_icons: status_icons,
        username: current_user.username,
        id: current_user.id})
      Pusher[params[:page_name]].trigger("new", chat_partial);

      if request.xhr?
        head :created
      end
    else
      render json: nil
    end
  end

  def silence
    if !!current_user
      page_owner = User.find_by_username(params[:page_name])
      mods = page_owner.page.moderators
      if current_user.username == page_owner.username || mods.include?(current_user)
        user = User.find_by_username(params[:username])
        if user.username == page_owner.username || mods.include?(user)
          render json: "You cannot silence an admin or mod"
        else
          Pusher[params[:page_name]].trigger("silence", params[:username]);
          render json: nil
        end
      else
        render json: "You do not have this privilege"
      end
    else
      render json: "log in"
    end
  end

end
