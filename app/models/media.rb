# encoding: utf-8

class Media < ActiveRecord::Base

  validates_presence_of :name,:summary,:sort,:visibility,:priority,:score,:browses,:push_home
  belongs_to  :user
  has_many :media_items

end
