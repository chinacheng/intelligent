class Comment < ActiveRecord::Base
  # content       评论内容 
  # address       发表评论的ip地址
  # show          是否展示评论
  # user_id       发表者
  # host_id       评论的对象的ID
  # host_type     评论对象的类型

  validates_presence_of :content,:address,:show,:host_id,:host_type
  belongs_to  :user
  belongs_to  :host, :polymorphic => true

  SHOW_ON = 1
  SHOW_OFF = 0

  module HostMethods
    def self.included(base)
      base.has_many :comments, :as => :host
    end

    def add_comments(comments_params)
      comment = self.comments.new(comments_params)
      comment.save
    end
  end

  module UserMethods
    def self.included(base)
      base.has_many :comments
    end
  end

end
