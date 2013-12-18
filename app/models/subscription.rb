class Subscription < ActiveRecord::Base
  attr_accessible :page_id, :user_id

  belongs_to(
  :page,
  class_name: "Page",
  foreign_key: :page_id,
  primary_key: :id
  )
  belongs_to(
  :user,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id
  )
end
