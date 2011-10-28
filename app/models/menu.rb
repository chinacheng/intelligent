class Menu < ActiveRecord::Base
  # name      菜单名称
  # app_id    菜单所属系统ID
  # sequence  菜单的顺序
  # image     菜单图片
	# tip       菜单悬浮提示信息
  # parent_id 父菜单ID
  validates_presence_of :name,:app_id,:sequence,:image,:tip
  validates_uniqueness_of :name
  acts_as_tree :order => "sequence ASC"
end
