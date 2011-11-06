class Comment < ActiveRecord::Base
  # content   评论内容 
  # sequence  评论顺序
  # sumit_address 发表评论的ip地址
  # show      是否展示评论
  # user_id   发表者
  # article_id  评论的文章ID
  validates_presence_of :content,:sequence,:sumit_address,:show
  belongs_to  :user
  belongs_to  :article

  SHOW_ON = 1
  SHOW_OFF = 0

end
