class InitTables < ActiveRecord::Migration
  def up
    create_table "articles", :force => true do |t|
      t.string   "name",        :limit => 128,                :null => false
      t.string   "summary",                                   :null => false
      t.text     "content",                                   :null => false
      t.string   "sort",        :limit => 32
      t.integer  "comment_tag",                :default => 0
      t.integer  "browses",                    :default => 0
      t.integer  "user_id"
      t.integer  "guide_id"
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

    create_table "guides", :force => true do |t|
      t.string   "name",       :limit => 32,                :null => false
      t.integer  "sequence",                                :null => false
      t.integer  "show",                     :default => 1, :null => false
      t.string   "way"
      t.integer  "parent_id"
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
      t.integer  "parent_id"
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
    end
  end

  def down
    drop_table "articles"
    drop_table "comments"
    drop_table "guides"
    drop_table "media"
    drop_table "media_items"
    drop_table "menus"
    drop_table "relatives"
    drop_table "roles"
    drop_table "user_roles"
    drop_table "users" 
  end
end
