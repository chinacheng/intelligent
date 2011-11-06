class Media < ActiveRecord::Base
  # ? 该模型还需要探讨 是否需要拆分
  # name      媒体主题名字
  # summary   摘要
  # sort      该媒体主体分类
  # visibility 可见度
  # priority  优先级
  # score     评分
  # browses   浏览量
  # column_id    是否需要该字段探讨 has_many 
  # push_home   是否希望推送至首页

  validates_presence_of :name,:summary,:sort,:visibility,:priority,:score,:browses,:push_home
  belongs_to  :user
  has_many :media_items
end
