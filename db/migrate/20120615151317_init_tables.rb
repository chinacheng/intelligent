class InitTables < ActiveRecord::Migration
  def up
    create_table "articles", :force => true do |t|
      t.string   "name",          :limit => 128,                    :null => false
      t.string   "summary",                                         :null => false
      t.text     "content",                                         :null => false
      t.string   "sort",          :limit => 32
      t.boolean  "allow_comment",                :default => true
      t.integer  "browses",                      :default => 0
      t.integer  "user_id"
      t.integer  "guide_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "is_pass",                      :default => true
      t.text     "refuse_reason"
      t.boolean  "is_top",                       :default => false
    end

    create_table "comments", :force => true do |t|
      t.string   "content",                                     :null => false
      t.string   "address",    :limit => 128
      t.boolean  "is_show",                   :default => true
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "host_id"
      t.string   "host_type"
    end

    create_table "dictionary_entities", :force => true do |t|
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "guides", :force => true do |t|
      t.string   "name",       :limit => 32,                    :null => false
      t.integer  "sequence"
      t.boolean  "is_show",                  :default => false, :null => false
      t.string   "way"
      t.integer  "parent_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "user_id"
      t.string   "uri"
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
      t.integer  "parent_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "pictures", :force => true do |t|
      t.integer  "user_id"
      t.text     "description"
      t.string   "photo_file_name"
      t.string   "photo_content_type"
      t.integer  "photo_file_size"
      t.datetime "photo_updated_at"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "relatives", :force => true do |t|
      t.integer  "fan_id"
      t.integer  "follow_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "roles", :force => true do |t|
      t.string   "name",       :limit => 32, :null => false
      t.string   "remark"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "code"
    end

    create_table "sessions", :force => true do |t|
      t.string   "session_id", :null => false
      t.text     "data"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
    add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

    create_table "topics", :force => true do |t|
      t.string   "name"
      t.text     "description"
      t.integer  "user_id"
      t.datetime "created_at",  :null => false
      t.datetime "updated_at",  :null => false
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
      t.string   "avatar_file_name"
      t.string   "avatar_content_type"
      t.integer  "avatar_file_size"
      t.datetime "avatar_updated_at"
      t.string   "status"
    end

    create_table "videos", :force => true do |t|
      t.integer  "user_id"
      t.text     "description"
      t.string   "url"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

  end

  def down

    drop_table "articles"
    drop_table "comments"
    drop_table "dictionary_entities"
    drop_table "guides"
    drop_table "media"
    drop_table "media_items"
    drop_table "menus"
    drop_table "pictures"
    drop_table "relatives"
    drop_table "roles"
    drop_table "sessions"
    drop_table "topics"
    drop_table "user_roles"
    drop_table "users"
    drop_table "videos"

  end

end
