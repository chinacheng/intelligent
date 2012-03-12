class ChangArticleAndGuides < ActiveRecord::Migration

  def change
    change_column :guides, :sequence, :integer, :null => true

    add_column :articles, :is_top, :boolean, :default => false
  end

end
