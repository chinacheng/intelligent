class AddTopPictures < ActiveRecord::Migration
  def up
    create_table "top_pictures", :force => true do |t|
      t.integer  "user_id"
      t.integer  "picture_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def down
    drop_table "top_pictures"
  end
end
