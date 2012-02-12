class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string  :name,:null => false,:limit => 128
      t.string  :summary,:null => false, :limit => 255
      t.text    :content,:null => false
      t.string  :sort,:limit => 32
      t.integer :comment_tag,:default => Article::CMMT_OFF
      t.integer :browses,:default => 0
      t.integer :user_id
      t.integer :column_id
      t.timestamps
    end
  end

  def self.down
    drop table :articles
  end
end
