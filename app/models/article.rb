# encoding: utf-8

class Article < ActiveRecord::Base

  validates_presence_of :name, :summary, :content, :user_id
  validates_length_of :name, :within => 0..128
  validates_length_of :sort, :within => 0..32

  belongs_to :user
  belongs_to :guide

  COMMENT_ON  = true
  COMMENT_OFF = false

  PASS_ON  = true
  PASS_OFF = false

  scope :passed, where(:is_pass => PASS_ON)
  scope :not_passed, where(:is_pass => PASS_OFF)

  include Comment::HostMethods

  def title
    name
  end

  def author
    user.name
  end

  def self.find_by_name_articles(article_name,size)
    articles = Article.find(:all,
                :conditions => ["name like '%?%'",article_name],
                :order => 'updated_at DESC',
                :limit => size)
  end 

  def toggle_is_pass
    if is_pass == PASS_ON
      return update_attributes(:is_pass => PASS_OFF)
    end
    update_attributes(:is_pass => PASS_ON)
  end

  def toggle_allow_comment
    if allow_comment == COMMENT_ON
      return update_attributes(:allow_comment => COMMENT_OFF)
    end
    update_attributes(:allow_comment => COMMENT_ON)
  end

  def is_pass?
    is_pass = Article::PASS_ON
  end

  def allow_comment?
    allow_comment == COMMENT_ON
  end

end
