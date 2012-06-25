class ModifyPictures < ActiveRecord::Migration
  def up
    remove_column :pictures, :topic_id
    add_column :pictures, :host_id, :integer
    add_column :pictures, :host_type, :string
  end

  def down
    add_column :pictures, :topic_id, :integer
  end
end
