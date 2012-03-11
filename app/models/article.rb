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
  validates_presence_of :name, :summary, :content, :user_id
  validates_length_of :name, :within => 0..128
  validates_length_of :sort, :within => 0..32

  belongs_to :user
  belongs_to :guide

  COMMET_ON  = true
  COMMET_OFF = false

  PASS_ON  = true
  PASS_OFF = false

  YES_ON = {"Yes" => true, "No" => false}

  include Comment::HostMethods

  def self.list
    Artile.find_all_by_is_show(true)
  end

  def self.find_by_name_articles(article_name,size)
    articles = Article.find(:all,
                :conditions => ["name like '%?%'",article_name],
                :order => "updated_at DESC",
                :limit => size)
    return articles
  end 

  module UserMethods
    def self.included(base)
      base.has_many :articles
    end
  end
 
end
