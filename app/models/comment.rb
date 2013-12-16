class Comment < ActiveRecord::Base
  attr_accessible :parent_id, :body, :video_id, :user_id
  validates :user_id, :video_id, presence: true

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
  belongs_to(
  :parent,
  class_name: "Comment",
  foreign_key: :parent_id,
  primary_key: :id
  )
  has_many(
  :replies,
  class_name: "Comment",
  foreign_key: :parent_id,
  primary_key: :id
  )

  def as_json(options)
    user = User.find(self.user_id)
    patch = {username: user.username, page_logo_url: Page.find_by_user_id(user.id).logo_url}
    super(options).merge(patch)
  end
end
