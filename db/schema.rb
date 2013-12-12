# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131211194353) do

  create_table "comments", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "video_id"
    t.integer  "user_id"
    t.string   "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["parent_id"], :name => "index_comments_on_parent_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"
  add_index "comments", ["video_id"], :name => "index_comments_on_video_id"

  create_table "containers", :force => true do |t|
    t.integer  "page_id"
    t.text     "body"
    t.string   "image_url"
    t.string   "image_url_link"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "containers", ["page_id"], :name => "index_containers_on_page_id"

  create_table "follows", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followee_id"
    t.boolean  "email_when_live"
    t.integer  "sort_priority"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "follows", ["followee_id"], :name => "index_follows_on_followee_id"
  add_index "follows", ["follower_id"], :name => "index_follows_on_follower_id"

  create_table "pages", :force => true do |t|
    t.integer  "user_id"
    t.string   "logo_url"
    t.string   "stream_title"
    t.string   "background_url"
    t.string   "banner_url"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "sessions", :force => true do |t|
    t.integer  "user_id"
    t.string   "session_token"
    t.string   "location"
    t.string   "device"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "sessions", ["session_token"], :name => "index_sessions_on_session_token"
  add_index "sessions", ["user_id"], :name => "index_sessions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.string   "short_bio"
    t.text     "long_bio"
    t.boolean  "is_admin"
    t.boolean  "show_status"
    t.string   "status"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "active"
  end

  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "video_favorites", :force => true do |t|
    t.integer  "video_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "video_favorites", ["user_id"], :name => "index_video_favorites_on_user_id"
  add_index "video_favorites", ["video_id"], :name => "index_video_favorites_on_video_id"

  create_table "videos", :force => true do |t|
    t.integer  "user_id"
    t.string   "thumbnail_url"
    t.string   "title"
    t.text     "description"
    t.string   "video_url"
    t.string   "game_title"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "videos", ["user_id"], :name => "index_videos_on_user_id"

  create_table "watchings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "page_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "watchings", ["page_id"], :name => "index_watchings_on_page_id"
  add_index "watchings", ["user_id"], :name => "index_watchings_on_user_id"

end
