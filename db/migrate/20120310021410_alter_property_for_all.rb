class AlterPropertyForAll < ActiveRecord::Migration

  def change
    change_column :articles, :comment_tag, :boolean, :default => true
    change_column :comments, :show, :boolean, :default => true
    change_column :guides, :show, :boolean, :default => false

    add_column :articles, :is_pass, :boolean, :default => true
    add_column :articles, :refuse_reason, :text

    rename_column :articles, :comment_tag, :has_comm
    rename_column :comments, :show, :is_show
    rename_column :guides, :show, :is_show
  end

end
