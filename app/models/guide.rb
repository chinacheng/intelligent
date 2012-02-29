class Guide < ActiveRecord::Base
  # name      栏目名称
  # sequence  栏目序列 
  # show      栏目显示与否
  # way       栏目在页面上的展示形式 (考虑是否需要字段)
  # parent_id 父栏目ID
  # user_id   创建人 
  # uri       链接
  validates_presence_of :name, :uri, :sequence, :show, :way, :user_id, :parent_id
  validates_uniqueness_of :name

  belongs_to :user

  acts_as_tree :order => "sequence ASC"

  # 顶级栏目的parent_id
  TOP_COLS = -1
  
  # 该栏目显示与否的标记
  COL_SHOW = 1
  COL_HIDE = 0

  module UserMethods
    def self.included(base)
      base.has_many :guides
    end
  end

  def self.list_display
    guides = Guide.find(:all,
                    :conditions => ["parent_id=? and `show`=?",Guide::TOP_COLS,Guide::COL_SHOW],
                    :order => "sequence ASC")
  end
end
