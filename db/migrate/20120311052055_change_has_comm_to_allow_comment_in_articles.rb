class ChangeHasCommToAllowCommentInArticles < ActiveRecord::Migration
  def up
    rename_column :articles, :has_comm, :allow_comment
    add_column :users, :status, :string
  end

  def down
    rename_column :articles, :allow_comment, :has_comm
    remove_column :users, :status
  end
end
