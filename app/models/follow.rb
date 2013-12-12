class Follow < ActiveRecord::Base
  attr_accessible :follower_id, :followee_id, :email_when_live

  belongs_to(
  :followed_user,
  class_name: "User",
  foreign_key: :followee_id,
  primary_key: :id
  )

  belongs_to(
  :follower_user,
  class_name: "User",
  foreign_key: :follower_id,
  primary_key: :id
  )
end
