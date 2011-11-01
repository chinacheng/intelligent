class CreateColumns < ActiveRecord::Migration
  def self.up
    create_table :columns do |t|
      t.string  :name,:null => false,:limit =>32
      t.integer :sequence,:null => false
      t.integer :show,:null => false, :default => Column::COL_SHOW
      t.string  :way
      t.integer :parent_id
      t.timestamps
    end
  end

  def self.down
    drop table :colums
  end
end
