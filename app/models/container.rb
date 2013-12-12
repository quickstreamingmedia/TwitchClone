class Container < ActiveRecord::Base
  attr_accessible :page_id, :body, :image_url, :image_url_link
  validates :page_id, presence: true

  belongs_to(
  :page,
  class_name: "Page",
  foreign_key: :page_id,
  primary_key: :id
  )
end
