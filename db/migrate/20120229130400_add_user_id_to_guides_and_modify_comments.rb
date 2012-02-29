class AddUserIdToGuidesAndModifyComments < ActiveRecord::Migration
  def change
    add_column :guides, :user_id, :integer
    add_column :guides, :uri, :string
    remove_column :comments, :article_id
    add_column :comments, :host_id, :integer
    add_column :comments, :host_type, :string
  end
end
