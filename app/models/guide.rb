class Guide < ActiveRecord::Base
  # name      栏目名称
  # sequence  栏目序列 
  # show      栏目显示与否
  # way       栏目在页面上的展示形式 (考虑是否需要字段)
  # parent_id 父栏目ID
  validates_presence_of :name,:sequence,:show,:way
# validates_uniqueness_of :name
#  acts_as_tree :order => "sequence ASC"
  validates_presence_of :parent_id
  SHOW_TYPES = [
    ["YES",1],
    ["NO", 0]
  ]

  # 顶级栏目的parent_id
  TOP_COLS = -1
  
  # 该栏目显示与否的标记
  COL_SHOW = 1
  COL_HIDE = 0

end
