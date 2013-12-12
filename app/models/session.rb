class Session < ActiveRecord::Base
  attr_accessible :user_id, :session_token, :location, :device
end
