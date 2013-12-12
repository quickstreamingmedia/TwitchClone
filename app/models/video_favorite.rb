class VideoFavorite < ActiveRecord::Base
  attr_accessible :video_id, :user_id

  belongs_to(
  :user,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id
  )

  belongs_to(
  :video,
  class_name: "Video",
  foreign_key: :video_id,
  primary_key: :id
  )
end
