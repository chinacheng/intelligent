class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer  :user_id
      t.text     :description
      t.string   :url
      t.timestamps
    end
  end
end
