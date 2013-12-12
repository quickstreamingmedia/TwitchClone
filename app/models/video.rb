class Video < ActiveRecord::Base
  attr_accessible :user_id, :thumbnail_url, :title, :description, :video_url, :game_title

  has_many(
  :favoritings,
  class_name: "VideoFavorite",
  foreign_key: :video_id,
  primary_key: :id
  )

  has_many :favorites, through: :favoritings, source: :user

  has_many(
  :comments,
  class_name: "Comment",
  foreign_key: :video_id,
  primary_key: :id
  )
end
