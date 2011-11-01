class Article < ActiveRecord::Base
  # name    文章名称
  # summary 文章摘要
  # content 文章内容
  # sort    文章分类
  # comment_tag 文章是否可评论标志
  # browses 文章浏览量
  # user    创建文章的用户
  # column  文章归属的栏目 
  # comment 文章评论
  validates_presence_of :name,:summary,:content,:sort,:comment_tag,:browses
  belongs_to :user
  belongs_to :column
  has_many  :comments

  CMMT_ON   = 1
  CMMT_OFF  = 0  
end
