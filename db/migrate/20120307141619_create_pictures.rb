class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer  :user_id
      t.text     :description
      t.string   :photo_file_name
      t.string   :photo_content_type
      t.integer  :photo_file_size
      t.datetime :photo_updated_at
      t.timestamps
    end
  end
end
