class CreateColumns < ActiveRecord::Migration
  def self.up
    create_table :columns do |t|
      t.string  :name,:null => false,:limit =>32
      t.integer :sequence,:null => false
      t.integer :show,:null => false, :default => Guide::COL_SHOW
      t.string  :way
      t.integer :parent_id
      t.timestamps
    end
    rename_table :columns,:guides
  end

  def self.down
    drop table :guides
  end
end
