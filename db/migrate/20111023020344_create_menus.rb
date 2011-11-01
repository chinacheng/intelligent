class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name,:full => false,:limit => 20
      t.string :app_id
      t.string :image,:limit => 255
      t.string :tip,:limit => 255
      t.integer :sequence
      t.integer :parent_id,:default => 0
      t.timestamps
    end
  end
end
