class Page < ActiveRecord::Base
  attr_accessible :user_id, :logo_url, :stream_title, :background_url, :banner_url
  validates :user_id, presence: true
  validates :user_id, uniqueness: true

  belongs_to(
  :user,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id
  )

  has_many(
  :current_viewers,
  class_name: "Watching",
  foreign_key: :page_id,
  primary_key: :id
  )

  has_many(
  :containers,
  class_name: "Container",
  foreign_key: :page_id,
  primary_key: :id
  )

  has_many(
  :moderator_objects,
  class_name: "Moderator",
  foreign_key: :page_id,
  primary_key: :id
  )
  has_many(
  :subscriptions,
  class_name: "Subscription",
  foreign_key: :page_id,
  primary_key: :id
  )

  has_many :viewers, through: :current_viewers, source: :user

  has_many :subscribers, through: :subscriptions, source: :user

  has_many :moderators, through: :moderator_objects, source: :user

  def logo
    (!!self.logo_url && self.logo_url != "") ? self.logo_url : "http://upload.wikimedia.org/wikipedia/commons/a/a4/Socrates_Louvre.jpg"
  end
end
