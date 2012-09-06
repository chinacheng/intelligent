# encoding: utf-8

class Comment < ActiveRecord::Base

  validates_presence_of :content,:address,:host_id,:host_type
  belongs_to :user
  belongs_to :host, :polymorphic => true

  SHOW_ON = true
  SHOW_OFF = false

  module HostMethods
    def self.included(base)
      base.has_many :comments, :as => :host
    end

    def add_comments(comments_params,user)
      comment = self.comments.new(comments_params)
      comment.user_id = user.id
      comment.save
    end

    def comments_count
      comments.count
    end
  end

  # allow anonymous comment
  # so when user is blank return the sign of annoymous
  def author
    user.blank? ? I18n.t('view.comments.anonymous') : user.name
  end

  def host_name
    case host_type 
    when 'Article' then host.name
    end
  end

  def toggle_allow_show 
    (is_show == SHOW_ON) ? update_attribute(:is_show,SHOW_OFF) : update_attribute(:is_show,SHOW_ON)    
  end
  
end
