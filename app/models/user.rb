class User < ActiveRecord::Base
  attr_accessible :username, :password, :email, :short_bio, :long_bio, :show_status, :status
  attr_reader :password
  attr_accessor :is_admin
  validates :username, uniqueness: true
  validates :username, presence: true
  validates :email, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :password_digest, presence: true

  has_many(
  :follows_followers,
  class_name: "Follow",
  foreign_key: :followee_id,
  primary_key: :id
  )
  #this should retrieve Follow objects for a user where this user is the followee

  has_many(
  :follows_followees,
  class_name: "Follow",
  foreign_key: :follower_id,
  primary_key: :id
  )
  #this should retrieve Follow objects for a user where this user is the follower

  has_many :follows, through: :follows_followees, source: :followed_user
  has_many :followers, through: :follows_followers, source: :follower_user

  has_one(
  :page,
  class_name: "Page",
  foreign_key: :user_id,
  primary_key: :id
  )

  has_many(
  :video_favorites,
  class_name: "VideoFavorite",
  foreign_key: :user_id,
  primary_key: :id
  )

  has_many :favorite_videos, through: :video_favorites, source: :video

  has_many(
  :comments,
  class_name: "Comment",
  foreign_key: :user_id,
  primary_key: :id
  )

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return user if !!user && user.has_password?(password)

    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def has_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    token = SecureRandom.urlsafe_base64(16)
    Session.create!(user_id: self.id, session_token: token)
    self.save!

    return token
  end

  # def reset_session_token!
#     self.session_token = SecureRandom.urlsafe_base64(16)
#     self.save!
#   end
end
