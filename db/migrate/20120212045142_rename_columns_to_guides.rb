class RenameColumnsToGuides < ActiveRecord::Migration
  def up
    rename_table :columns,:guides
    rename_column :articles,:column_id, :guide_id
  end

  def down
  end
end
