class Comment < ActiveRecord::Base
  # content       评论内容 
  # address       发表评论的ip地址
  # show          是否展示评论
  # user_id       发表者
  # host_id       评论的对象的ID
  # host_type     评论对象的类型

  validates_presence_of :content,:address,:host_id,:host_type
  belongs_to  :user
  belongs_to  :host, :polymorphic => true

  SHOW_ON = true
  SHOW_OFF = false

  HOST_TYPE_ARTICLE = "Article"

  HOST_TYPE_MAP = { "Article" => I18n.t("view.comments.host_type_article")}

  module HostMethods
    def self.included(base)
      base.has_many :comments, :as => :host
    end

    def add_comments(comments_params,user)
      comment = self.comments.new(comments_params)
      comment.user_id = user.id
      comment.save
    end
  end


  def author
    user = User.find_by_id(user_id)

    if user == nil
      return I18n.t("view.comments.anonymous")
    end

    user.name
  end

  def host_name_view
    case host_type 
    when HOST_TYPE_ARTICLE then Article.find_by_id(host_id).name
    end
  end

  def host_type_view
    HOST_TYPE_MAP[host_type]
  end

  def stat
    Comment.count(:conditions=>["host_id = ? AND host_type = ?",host_id,host_type])
  end

  def toggle_allow_show 
    if is_show == SHOW_ON
      return update_attribute(:is_show,SHOW_OFF)
    end
    update_attribute(:is_show,SHOW_ON)    
  end
  
end
