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

ActiveRecord::Schema.define(:version => 20111031124829) do

  create_table "articles", :force => true do |t|
    t.string   "name",        :limit => 128,                :null => false
    t.string   "summary",                                   :null => false
    t.text     "content",                                   :null => false
    t.string   "sort",        :limit => 32
    t.integer  "comment_tag",                :default => 0
    t.integer  "browses",                    :default => 0
    t.integer  "user_id"
    t.integer  "column_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "columns", :force => true do |t|
    t.string   "name",       :limit => 32,                :null => false
    t.integer  "sequence",                                :null => false
    t.integer  "show",                     :default => 1, :null => false
    t.string   "way"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "content",                                       :null => false
    t.integer  "sequence",                                      :null => false
    t.string   "sumit_address", :limit => 128
    t.string   "show",                         :default => "0"
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media", :force => true do |t|
    t.string   "name",       :limit => 64,                                                  :null => false
    t.string   "summary",    :limit => 128
    t.string   "sort",       :limit => 32
    t.integer  "visibility",                                              :default => 0
    t.integer  "priority",                                                :default => 0
    t.decimal  "score",                     :precision => 3, :scale => 1, :default => 10.0
    t.integer  "browses",                                                 :default => 0
    t.integer  "push_home"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media_items", :force => true do |t|
    t.string   "name",       :limit => 64
    t.string   "summary",    :limit => 128
    t.string   "path"
    t.integer  "media_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", :force => true do |t|
    t.string   "name",       :limit => 20
    t.string   "app_id"
    t.string   "image"
    t.string   "tip"
    t.integer  "sequence"
    t.integer  "parent_id",                :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",       :limit => 32, :null => false
    t.string   "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.string   "gender"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
