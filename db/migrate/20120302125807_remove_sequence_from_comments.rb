class RemoveSequenceFromComments < ActiveRecord::Migration
  def up
    remove_column :comments, :sequence
    rename_column :comments, :sumit_address, :address
  end

  def down
    add_column :comments, :sequence, :integer
    rename_column :comments, :address, :sumit_address
  end
end
