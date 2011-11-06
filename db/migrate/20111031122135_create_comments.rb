class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string  :content,:null => false,:limit => 255
      t.integer :sequence,:null => false
      t.string  :sumit_address,:limit => 128
      t.string  :show,:default => Comment::SHOW_OFF
      t.integer :user_id
      t.integer :article_id
      t.timestamps
    end
  end

  def self.down
    drop table :comments
  end
end
