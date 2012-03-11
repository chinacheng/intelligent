class Guide < ActiveRecord::Base
  # name      栏目名称
  # sequence  栏目序列 
  # is_show      栏目显示与否
  # way       栏目在页面上的展示形式 (考虑是否需要字段)
  # parent_id 父栏目ID
  # user_id   创建人 
  # uri       链接
  validates_presence_of :name, :uri, :sequence, :is_show, :way, :user_id, :parent_id
  validates_uniqueness_of :name

  belongs_to :user

  acts_as_tree :order => "sequence ASC"

  # 顶级栏目的parent_id
  TOP_COLS = -1

  YES_ON = {"Yes" => true, "No" => false}

  def self.list_display
    Guide.find_all_by_is_show(true)
  end
  
  def uri_path
    if uri.blank?
      return "/"
    end
    uri
  end

  module UserMethods
    def self.included(base)
      base.has_many :guides
    end
  end

end
