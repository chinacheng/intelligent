class CreateMedia < ActiveRecord::Migration
  def self.up
    create_table :media do |t|
      t.string :name,:null => false,:limit => 64
      t.string :summary,:limit => 128
      t.string :sort,:limit => 32
      t.integer :visibility,:default => 0
      t.integer :priority,:default => 0
      t.decimal :score,:precision =>3 ,:scale => 1,:default => 10.0
      t.integer :browses,:default => 0
      t.integer :push_home
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :media
  end
end
