class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
			t.string :name, :null => false,:limit => 32
      t.string :remark, :limit => 255
      t.timestamps
    end
  end
end
