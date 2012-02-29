class AddUriToGuides < ActiveRecord::Migration
  def change
    add_column :guides, :uri, :string
  end
end
