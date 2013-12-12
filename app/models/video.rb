class Video < ActiveRecord::Base
  attr_accessible :user_id, :thumbnail_url, :title, :description, :video_url, :game_title
  validates :user_id, presence: true

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

  belongs_to(
  :user,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id
  )

  def comments_by_parent_id
    comment_hash = {}
    self.comments.each do |comment|
      comment_hash[comment.id] = comment.replies unless comment.replies.empty?
    end
    comment_hash[nil] = comments.where("parent_id IS NULL")
    comment_hash
  end

end
