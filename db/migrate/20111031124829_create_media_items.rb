class CreateMediaItems < ActiveRecord::Migration
  def self.up
    create_table :media_items do |t|
      t.string  :name,:limit => 64
      t.string  :summary,:limit => 128
      t.string  :path
      t.integer :media_id
      t.timestamps
    end
  end

  def self.down
    drop_table :media_items
  end
end
