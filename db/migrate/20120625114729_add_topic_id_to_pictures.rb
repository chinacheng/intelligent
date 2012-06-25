class AddTopicIdToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :topic_id, :integer
  end
end
