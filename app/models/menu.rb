class Menu < ActiveRecord::Base

  validates_presence_of :name,:app_id,:sequence,:image,:tip
  validates_uniqueness_of :name
  acts_as_tree :order => "sequence ASC"

end
