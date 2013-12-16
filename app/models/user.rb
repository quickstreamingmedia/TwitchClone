class User < ActiveRecord::Base
  attr_accessible :username, :password, :email, :short_bio, :long_bio, :show_status, :status
  attr_reader :password
  attr_accessor :is_admin
  validates_uniqueness_of :username, case_sensitive: false
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

  has_many(
  :videos,
  class_name: "Video",
  foreign_key: :user_id,
  primary_key: :id
  )
  has_many(
  :moderator_objects,
  class_name: "Moderator",
  foreign_key: :user_id,
  primary_key: :id
  )

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return user if !!user && user.has_password?(password)

    nil
  end

  def get_follows
    self.setup_follows_and_followers
    self.follows
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

  def setup_follows_and_followers
    @user_follows = self.follows
    user_names = @user_follows.map{ |x| x.username.downcase }
    @streams_info = JSON.parse(RestClient.get("https://api.twitch.tv/kraken/streams?channel=#{user_names.join('%2C')}"))["streams"]

    @streams_info.each do |stream|
      next if stream.nil?
      if stream["channel"]
        live_user = @user_follows.find{ |x| x.username.downcase == stream["channel"]["display_name"].downcase }
        if !!live_user && live_user.status != "(LIVE)"
          live_user.update_attribute(:status, "(LIVE)")
        end
        if live_user.status == "(LIVE)"
          Page.find_by_user_id(live_user.id).update_attribute(:stream_title, stream["channel"]["status"])
        end
      end
    end

    @user_follows.each do |follow|
      if !@streams_info.find{|x| !x.nil? && x["channel"]["display_name"].downcase == follow.username.downcase }
        follow.update_attribute(:status, nil) if follow.status == "(LIVE)"
      end
    end

    @user_follows = @user_follows.select{ |x| x.status == "(LIVE)"} + @user_follows.reject{ |x| x.status == "(LIVE)"}

    @user_followers = self.followers

  end

end
